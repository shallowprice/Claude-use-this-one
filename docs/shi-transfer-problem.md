# Shi's prime-to-zero transfer problem — precise specification

Target: the open lemma named in **arXiv 2609.04908** (Yaoming Shi, *Construction
of Finite Hilbert–Pólya Matrices from Weil's Explicit Formula*, 4 Sept 2026),
§4.9 Eq. 4.51, §5.7, §6.1, §11.

Everything below is read from the paper's full text. The numerical checks in §5
are ours, computed in-session with mpmath against real zeta ordinates.

---

## 1. The objects

Fix `N` (number of ordinates) and `L` (logarithmic Fourier window). All matrices
act on a space of dimension `M = 2N+1`.

- **`S_{N,L}`** — the **arithmetic Prime–Weil matrix**. Real symmetric,
  constructed from the Riemann-`Ξ` specialization of Weil's explicit formula out
  of **pole, archimedean and finite prime-power data only**. No zeros are used.
  Off-diagonal entries are divided differences of a single generating sequence;
  `[S, D]` has **rank ≤ 2**; invariant under Fourier reflection.
- **`D_{L,N}`** — diagonal frequency matrix, nodes `ν_{n,L} = 2πn/L`.
- **`ε_{N,L} := λ_min(S_{N,L})`**, and `W_{N,L} := S_{N,L} − ε_{N,L} I`.
- **`C_{N,L}`** — compression onto the fixed **zero-mean contrast space**.
- The **arithmetic pencil**  `G := C* W C`,  `K := C* W D C`.
  The rank-two commutator is exactly what makes `K` Hermitian; the pencil is
  Hermitian-definite whenever `ε` is simple and `G ≻ 0`. Invariant under every
  positive affine rescaling `S ↦ aS + bI`.

**Under RH only**, the explicit formula lets one write (Eq. 6.2)

    S_{N,L} = 2 Σ_{j≥1} m_j H_L^G(γ_j) ,          hence S ⪰ 0,

and split off the first `N` ordinates (Eq. 6.3–6.4)

    S = S^[N] + R ,   S^[N] := 2 Σ_{j≤N} m_j H_L^G(γ_j) ,   R := 2 Σ_{j>N} … ⪰ 0.

The **zero-side pencil** is `G⁰ := C* S^[N] C`, `K⁰ := C* S^[N] D C`, and the
perturbations are (Eq. 4.49–4.50)

    ΔG := C*(R − εI) C ,    ΔK := C*(R − εI) D C .

## 2. What is already proved

**(P1) Exact finite-dimensional structure.** Explicit-formula entries, divided
difference identities, the rank-two commutator, Hermiticity of the contrast
pencil, affine-scale invariance, parity reduction. Unconditional.

**(P2) Exact zero-side reconstruction** (Thm 5.2, Eq. 11.1). For `N` distinct
positive reals `0 < γ_1 < … < γ_N` fed in as data,

    det(z G⁰ − K⁰) = det(G⁰) · Π_{k=1}^{N} (z² − γ_k²),

so the pencil spectrum is exactly `{±γ_1, …, ±γ_N}` and the positive-parity
square is `{γ_1², …, γ_N²}`. **The ordinates are inputs** — this is a
reconstruction and consistency theorem.

**(P3) Vanishing least arithmetic eigenvalue under RH** (Thm 6.1). With
`ν_{N,L} = 2πN/L < γ_1`, the interpolation null vector `e_{N,L}` (which
annihilates `S^[N]` exactly) is a Rayleigh trial state for the **full** matrix,
leaving only the positive tail:

    0 ≤ λ_1(N,L) ≤ 8(2N+1)/L² · Σ_{j>N} m_j/γ_j²          (Eq. 6.9)

hence `λ_1(N,N) → 0` since `2π < γ_1`. Sharper product form (Eq. 6.21):

    λ_1(N,L) ≤ (8/L²) · [ Π_{j≤N} (2πj / (L γ_j))⁴ ] · Σ_{j>N} m_j/γ_j²

and for simple zeros `log λ_1(N,N) ≤ −4N log(N/log N) + O(N)` (Eq. 6.23).

**(P4) Numerics.** At `N = L = 13`, Lemke's quotient and the contrast pencil
agree to ≥ 62 decimal places, and the first three eigenvalues match `γ_1, γ_2,
γ_3` with errors `1.54×10⁻²⁷`, `1.52×10⁻¹⁶`, `1.72×10⁻¹¹`.

**(P5) Off-line structure** (§7–§9). A hypothetical conjugate pair `γ_k ± iη_k`
produces the **quartet** `{±(γ_k+iη_k), ±(γ_k−iη_k)}`, *not* radial values
`±√(γ_k²+η_k²)`. At atom level (Thm 8.4): a **real** spectral parameter gives a
**positive rank-two** operator of trace one; a genuine **nonreal** pair gives an
**indefinite rank-four** self-adjoint operator.

## 3. The missing theorem, stated

> **Theorem (T) — relative prime-to-zero spectral transfer.**
> There is a coupling `L = L(N) → ∞` such that:
>
> **(a) Relative pencil bound (Eq. 4.51).** For every fixed `R > 0`,
>
>     sup_{|z| ≤ R} ‖ (G⁰)^(−1/2) ( ΔK − z ΔG ) (G⁰)^(−1/2) ‖_op  ⟶  0 .
>
> **(b) Separation.** The reference generalized eigenvalues `±γ_1, …, ±γ_N`
> remain separated, quantitatively dominating the bound in (a).
>
> **(c) Uniform metric control.** A uniform lower bound — or a preconditioned
> equivalent — on the compressed metric `G⁰`.
>
> **(d) Limit.** A limiting operator or determinant exists, preserving
> multiplicities and excluding spectral pollution.
>
> Then standard Hermitian-pencil perturbation theory transfers each fixed low
> ordinate from the zero side to the arithmetic side.

Shi is explicit that weaker statements do **not** suffice: *"Entrywise
convergence of the uncompressed Weil matrices, or smallness of one Rayleigh
quotient, is not sufficient."* (P3) controls exactly one trial direction; (a)
controls the entire tail relative to the finite-zero quotient energy. The norm
in (a) is invariant under change of contrast basis and under common positive
rescaling of the metric — that is the point of writing it this way.

Note also (§5.7): when `L` changes **all nodes `ν_{n,L}` move**, so consecutive
arithmetic matrices are *not* nested principal submatrices. No induction on `N`.

---

## 4. The logical status — read this before investing

**Theorem (T) would not prove RH.** The decomposition `S = S^[N] + R` with
`R ⪰ 0` is *derived under RH* — Eq. 6.2 requires all ordinates real to express
`S` as a positive combination of the `H_L^G(γ_j)`, and Shi states the hypothesis
("Assume RH") at Thm 6.1. Both `G⁰` and `ΔG` are defined through that split. So
(T) reads:

> *assuming RH*, the arithmetic pencil spectrum converges to the zeta ordinates.

That is a **transfer / consistency theorem**, completing the Hilbert–Pólya
realization *given* RH. Valuable, well-posed, and not a proof of RH. Shi says as
much in §11 and in his abstract.

**Where the RH content actually sits.** `S_{N,L}` is computable from primes with
no knowledge of the zeros. Read Eq. 6.2 backwards and combine with (P5): an
off-line conjugate pair contributes an **indefinite rank-four** piece, whereas
every real ordinate contributes a **positive rank-two** piece. Therefore

    proving  S_{N,L} ⪰ 0  from the prime side, unconditionally  ⟹  RH.

That is Weil positivity, restricted to Shi's log-Fourier test class. His
framework makes it finite-dimensional, explicitly computable and affine-scale
invariant — genuine value — but it does not escape the equivalence we started
from. **The inertia statement, not Eq. 4.51, is the RH mechanism here.**

So there are two separable projects, and they should not be confused:

| | Statement | Proves RH? | Tractability |
|---|---|---|---|
| **(T)** | Eq. 4.51 + (b)(c)(d), under RH | No — consistency | Hard, well-posed |
| **(I)** | `S_{N,L} ⪰ 0` from prime data | **Yes** | = Weil positivity |

---

## 5. Why (T) is hard — quantified

Shi's own conditioning table (§4.6), with `g := λ_2 − λ_1` and
`q := |δ̂* ê|` the overlap between the evaluation functional and the near-null
direction. **Proposition 4.4** proves the two-sided bracket

    g · q²  ≤  λ_min(G)  ≤  M · q² ,          M := ‖W‖_op

i.e. **the quotient metric degenerates quadratically in the overlap.**

| `N=L` | `λ_1` | gap `g` | `q` | `q²` | `g·q²` (floor on `λ_min(G)`) |
|---|---|---|---|---|---|
| 2 | 1.168e−8 | 2.142e−6 | 4.530e−4 | 2.053e−7 | 4.40e−13 |
| 5 | 2.660e−24 | 2.872e−21 | 1.144e−11 | 1.308e−22 | 3.76e−43 |
| 7 | 2.017e−35 | 5.773e−32 | 3.887e−17 | 1.511e−33 | 8.72e−65 |
| 11 | 1.068e−58 | 7.704e−55 | 1.337e−28 | 1.786e−56 | 1.38e−110 |
| 13 | 7.219e−71 | 5.798e−67 | 1.084e−34 | 1.175e−68 | **6.81e−135** |

**Consequence for (a).** Eq. 4.51 sandwiches `ΔK − zΔG` between two factors of
`(G⁰)^(−1/2)`, an amplification of order `q⁻²`. Fitting Shi's table gives
`log₁₀ q ≈ −2.79 N`, so

    amplification  q⁻²  ≳  10^(5.6 N) ,

and this **understates** it — the per-`N` slope steepens monotonically
(−1.67 → −2.61). At `N = 13` the amplification is already `~1.5×10⁶⁷` and the
metric floor is `~10⁻¹³⁵`. Any proof of (a) must control the positive zero tail
to a relative precision that tightens **exponentially in `N`**.

### Our independent check of (P3)

We recomputed Shi's bounds against true zeta ordinates (mpmath, 60 dps, tail
`Σ_{j>N} γ_j⁻²` summed to `j = 400` plus the Riemann–von Mangoldt integral):

| `N` | Shi's reported `λ_1` | Eq. 6.21 product bound | Eq. 6.9 crude bound | holds? |
|---|---|---|---|---|
| 2 | 1.1682e−8 | 6.17e−7 | 0.158 | ✓ |
| 5 | 2.6600e−24 | 2.55e−20 | 0.0431 | ✓ |
| 7 | 2.0168e−35 | 3.25e−30 | 0.0268 | ✓ |
| 11 | 1.0679e−58 | 1.98e−51 | 0.0140 | ✓ |
| 13 | 7.2193e−71 | 1.19e−62 | 0.0110 | ✓ |

**The product bound holds at every tested `N`** — so Shi's claim that the product
geometry (Eq. 6.21), not coincidence, explains the observed collapse checks out.
Two observations he does not spell out:

1. **Eq. 6.9 is useless for this purpose.** It yields `~10⁻²` at `N = 13` against
   an observed `7×10⁻⁷¹` — 69 orders of magnitude of slack. Only the product form
   captures the behaviour. Anyone quoting "`λ_1 → 0`" as evidence should quote
   Eq. 6.21, not Eq. 6.9.
2. **Eq. 6.21 is itself loose by ~8 orders** at `N = 13` (1.19e−62 vs 7.22e−71)
   and the slack widens with `N`. It has the right shape, not the right constant.

### The structural point

`λ_1 ~ 10⁻⁷¹` while `‖W‖` is `O(1)`: the arithmetic matrix is **exponentially
ill-conditioned in `N`**, and the zeta ordinates live in the bottom `~10⁻⁶⁷` of
its spectrum. Compare Groskin (2607.02828) in the entirely independent
Connes–van Suijlekom / CCM truncation: a spectral scale of `10⁻⁵⁹` at cutoff
`c = 100`, needing archimedean cutoff `T ~ 10⁶³` to resolve by brute force.

**Two unrelated finite-Weil constructions hit the same ~10⁻⁶⁰…10⁻⁷⁰ pathology at
comparable truncation size.** That is evidence the ill-conditioning is intrinsic
to extracting zeros from finite Weil data, not an artifact of either
parametrization. It is the single most important empirical regularity in this
part of the frontier.

---

## 6. Attack routes, ranked

**R1 — Import Groskin's certification calculus into Shi's setting.** Groskin
(2607.02828) has, for the CCM truncation, exactly what Shi lacks: a **two-sided
certification rule** with explicit budget `B_T ≈ (2N+1)ρ log T/(π²T)`, plus an
exact finite Guinand–Weil dictionary making every truncated-form value an exact
sum over the zeros. Shi has no analogue. Building one would put project **(I)**
— the real RH mechanism — on a footing where finite computation can certify or
refute cutoff-free positivity. **Highest value; the two papers have not been
connected and are three months apart.**

**R2 — Exploit that the near-null direction is known in closed form.** The
degeneracy is not mysterious: `e_{N,L}` is given explicitly by rational
interpolation (Thm 5.2), with central coordinate
`e_0 = √L · Π γ_j² / ((2π/L)^{2N} (N!)²)` (Eq. 6.20). Working in its exact
orthogonal complement replaces the `q⁻²` amplification with `1/g`. **Caveat: our
table shows `g` is itself collapsing (`5.8×10⁻⁶⁷` at `N=13`), so this buys
conditioning, not asymptotics.** Worth doing for numerical reach; it does not
solve (a).

**R3 — Prove (a) under RH.** Well-posed and publishable as a consistency
theorem. The obstacle is precisely the `10^(5.6N)` amplification: one needs tail
bounds on `R_{N,L}` sharp to exponentially small relative error, uniformly over
`|z| ≤ R`. Shi's fixed-test-function estimates explicitly **do not** settle this,
because the log-Fourier windows move with `N` and `L`.

**R4 — Attack the inertia side directly.** Prove `S_{N,L} ⪰ 0` from prime data
for the raised-cosine / spline-windowed families of Appendix A. This is (I) and
would give RH. Expect it to be exactly as hard as Weil positivity, because it is
Weil positivity.

### Cross-link worth flagging

Shi §6.1 states his truncation-plus-tail decomposition is *"analogous in spirit
to the finite-Weil-matrix strategy of Alpöge and Furman [1]"* — the verification
team on the Claude 67.25% result, whose method controlled **rank, trace,
Hilbert–Schmidt norm and inertia** of a finite Weil matrix in a high-energy
zero-counting problem. The difference Shi identifies: there, rank/trace control
sufficed; here rational interpolation annihilates the finite block exactly, so
the least-eigenvalue statement reduces to a scalar tail estimate, and **recovery
of individual ordinates is the separate relative-pencil problem.**

Note what that implies for R4: Alpöge–Furman got unconditional arithmetic out of
inertia control on a finite Weil matrix. That is the closest existing precedent
for (I) — and a reminder that Lamzouri then showed their Weil-matrix framework
was replaceable by a Hilbert-space inequality. Whether the same deflation applies
to Shi's inertia statement is an open and worthwhile question.

---

## Sources

Primary: arXiv **2609.04908** (full text read in-session).
Cross-referenced: 2607.02828, 2605.20224 (Groskin); 2511.22755 (CCM);
2511.23257 (Connes–van Suijlekom); 2606.09096 (Suzuki); 2609.02882 (Lamzouri).
Numerical checks: mpmath 1.4.1, 60 dps, `scratchpad/verify_shi.py`.
