from mpmath import mp, mpf, zetazero, log, pi, quad, inf
mp.dps = 60

NMAX = 400
print("computing zeta zeros...", flush=True)
g = [None] + [zetazero(k).imag for k in range(1, NMAX+1)]
print(f"gamma_1={g[1]}  gamma_13={g[13]}\n")

# tail sum  sum_{j>N} 1/gamma_j^2  (simple zeros), exact part + Riemann-von Mangoldt tail integral
# density of ordinates near t:  dN/dt = log(t/2pi)/(2pi)
def tail(N):
    s = sum(1/g[j]**2 for j in range(N+1, NMAX+1))
    T = g[NMAX]
    s += quad(lambda t: log(t/(2*pi))/(2*pi) / t**2, [T, inf])
    return s

# Shi Eq 6.21 with L=N:  lam1 <= (8/N^2) * prod_{j<=N} (2 pi j /(N gamma_j))^4 * tail(N)
def bound621(N):
    P = mpf(1)
    for j in range(1, N+1):
        P *= (2*pi*j/(N*g[j]))**4
    return (8/mpf(N)**2) * P * tail(N)

# Shi Eq 6.9 :  lam1 <= 8(2N+1)/L^2 * tail(N),  L=N
def bound69(N):
    return 8*(2*N+1)/mpf(N)**2 * tail(N)

reported = {2:'1.1682e-8', 5:'2.6600e-24', 7:'2.0168e-35', 11:'1.0679e-58', 13:'7.2193e-71'}
q_rep    = {2:4.5305e-4, 5:1.1438e-11, 7:3.8868e-17, 11:1.3366e-28, 13:1.0838e-34}

print(f"{'N':>3} {'Shi reported l1':>16} {'Eq6.21 bound':>16} {'Eq6.9 bound':>14}  {'6.21 holds?':>11}")
for N in (2,5,7,11,13):
    b21, b9 = bound621(N), bound69(N)
    rep = mpf(reported[N])
    ok = "YES" if rep <= b21 else "VIOLATED"
    print(f"{N:>3} {reported[N]:>16} {mp.nstr(b21,5):>16} {mp.nstr(b9,5):>14}  {ok:>11}")

print("\n--- overlap q and the amplification in Eq 4.51 ---")
print(f"{'N':>3} {'q':>12} {'q^-2':>12} {'log10 q':>9} {'log10q/N':>9}")
for N,q in q_rep.items():
    import math
    print(f"{N:>3} {q:>12.4e} {q**-2:>12.4e} {math.log10(q):>9.3f} {math.log10(q)/N:>9.3f}")
