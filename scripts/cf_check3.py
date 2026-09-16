import numpy as np
g = np.random.default_rng(3)

def herm_toeplitz(n, g):
    c = np.concatenate([[g.normal()], g.normal(size=n) + 1j*g.normal(size=n)])
    c[0] = c[0].real
    return np.array([[c[j-k] if j >= k else np.conj(c[k-j])
                      for k in range(n+1)] for j in range(n+1)]), c

print("Q: does the MINIMAL eigenvector give roots on the circle, with NO positivity?")
print("   (cf_check2 used argmin|w| -- the eigenvalue NEAREST zero. That was the wrong vector.)\n")
print(f"{'n':>2} {'lam_min':>10} {'PSD?':>6} {'gap':>9} {'min-evec:max||r|-1|':>20} {'nearest-0 evec':>15}")
for n in (3,4,5,6,8):
    for t in range(3):
        T, c = herm_toeplitz(n, g)
        w, U = np.linalg.eigh(T)                 # ascending
        xi_min  = U[:, 0]                        # MINIMAL eigenvalue
        j = int(np.argmin(np.abs(w)))
        xi_near = U[:, j]                        # nearest zero  (what cf_check2 used)
        e_min  = max(abs(abs(r)-1) for r in np.roots(xi_min[::-1]))
        e_near = max(abs(abs(r)-1) for r in np.roots(xi_near[::-1]))
        print(f"{n:>2} {w[0]:>10.4f} {str(w[0]>=0):>6} {w[1]-w[0]:>9.4f} {e_min:>20.3e} {e_near:>15.3e}")
