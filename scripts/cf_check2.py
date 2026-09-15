import numpy as np
# Lemma A claim: T Hermitian Toeplitz (NOT necessarily PSD), T xi = 0, xi_n != 0
#   ==>  C^H T' C = T'.   Positivity is NOT needed for the identity.
g = np.random.default_rng(11)
print("Lemma A without positivity (indefinite Hermitian Toeplitz):")
for n in (3,4,6):
    for trial in range(3):
        # random Hermitian Toeplitz with a kernel: pick c_1..c_n free, solve c_0 to force singularity
        for _ in range(500):
            c = np.concatenate([[g.normal()], g.normal(size=n)+1j*g.normal(size=n)])
            c[0] = c[0].real
            T = np.array([[c[j-k] if j>=k else np.conj(c[k-j]) for k in range(n+1)] for j in range(n+1)])
            w,U = np.linalg.eigh(T)
            i = np.argmin(np.abs(w))
            if abs(w[i]) < 1e-9: break
            # force a kernel: shift spectrum
            T = T - w[i]*np.eye(n+1)   # still Hermitian Toeplitz (shifts c_0 only, stays real)
            w,U = np.linalg.eigh(T); i = np.argmin(np.abs(w))
            if abs(w[i]) < 1e-9: break
        xi = U[:, i]
        if abs(xi[n]) < 1e-9: continue
        Tp = T[:n,:n]
        C = np.zeros((n,n), dtype=complex)
        for j in range(n-1): C[j+1,j]=1.0
        C[:,n-1] = -xi[:n]/xi[n]
        err = np.abs(C.conj().T@Tp@C - Tp).max()
        indef = (np.linalg.eigvalsh(T).min() < -1e-9)
        print(f"  n={n} trial={trial}: T indefinite={indef!s:5s}  ||C^H T' C - T'|| = {err:.2e}"
              f"   max||root|-1|={max(abs(abs(r)-1) for r in np.roots(xi[::-1])):.2e}")
