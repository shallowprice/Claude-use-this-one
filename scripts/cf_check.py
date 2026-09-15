import numpy as np
rng = np.random.default_rng(7)
np.set_printoptions(precision=3, suppress=True)

def build(n, seed):
    """PSD Toeplitz T of size (n+1), rank n, via Caratheodory-Fejer form VDV*."""
    r = rng.default_rng if False else None
    g = np.random.default_rng(seed)
    th = np.sort(g.uniform(0, 2*np.pi, n))          # n distinct nodes
    z  = np.exp(1j*th)
    al = g.uniform(0.5, 2.0, n)                      # positive weights
    V  = np.vander(z, n+1, increasing=True).T        # (n+1) x n , V[j,m] = z_m^j
    T  = V @ np.diag(al) @ V.conj().T
    return T, z, al

def kernel_vec(T):
    w, U = np.linalg.eigh(T)
    return U[:, 0], w                                # smallest eigenvalue's vector

print("="*78)
for n in (3, 5, 8):
    for seed in (1, 2):
        T, z, al = build(n, seed)
        xi, w = kernel_vec(T)
        # --- Toeplitz check
        toep = max(abs(T[j,k] - T[j-k+ (0), 0] if j>=k else 0) for j in range(n+1) for k in range(n+1))
        c = np.array([T[l,0] for l in range(n+1)])
        toep = max(abs(T[j,k] - (c[j-k] if j>=k else np.conj(c[k-j]))) for j in range(n+1) for k in range(n+1))
        rank = np.linalg.matrix_rank(T, tol=1e-8)

        # --- roots of P
        P = xi                                        # P(z) = sum xi_j z^j
        roots = np.roots(P[::-1])                     # numpy wants highest-first
        modmax = max(abs(abs(rt)-1) for rt in roots)

        # --- leading n x n block positive definite?
        Tp = T[:n, :n]
        eigTp = np.linalg.eigvalsh(Tp)

        # --- companion matrix of P/xi_n : mult-by-X on basis 1,X,...,X^{n-1}
        C = np.zeros((n, n), dtype=complex)
        for j in range(n-1):
            C[j+1, j] = 1.0
        C[:, n-1] = -xi[:n]/xi[n]

        ident = C.conj().T @ Tp @ C - Tp             # THE KEY IDENTITY
        eigC  = np.linalg.eigvals(C)

        print(f"n={n} seed={seed}:  rank(T)={rank} (want {n})   Toeplitz err={toep:.2e}")
        print(f"   |xi_0|={abs(xi[0]):.4f}  |xi_n|={abs(xi[n]):.4f}   max||root|-1| = {modmax:.3e}")
        print(f"   lambda_min(T') = {eigTp[0]:.6e}   (PD iff > 0)")
        print(f"   || C^H T' C  -  T' ||  = {np.abs(ident).max():.3e}   <-- key identity")
        print(f"   max||eig(C)|-1| = {max(abs(abs(e)-1) for e in eigC):.3e}")
        print(f"   eig(C) vs roots(P) match = {np.abs(np.sort_complex(eigC)-np.sort_complex(roots)).max():.3e}")
        print()
