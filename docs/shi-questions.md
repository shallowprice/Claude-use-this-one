# Questions for Yaoming Shi — arXiv 2609.04908

Prepared 2026-09-15 from a full read of the paper plus independent numerical
checks (`scripts/verify_shi.py`). Ordered by what would most change the project.
Companion: `docs/shi-transfer-problem.md`.

Checked first that none of these is answered in the paper: §1.1–1.5, §4.6, §4.9,
§5.7, §6, §6.1, §7.3, §10.8–10.9, §11, §13.10 and the reference list were all
read in full.

---

## Q1 — The de-conditionalizing tool is in your own reference [1]

**This is the question.** Everything else is secondary.

Eq. 4.51 and the whole `S = S^[N] + R`, `R ⪰ 0` decomposition are derived under
RH (Eq. 6.2 needs real ordinates to write `S` as a positive combination of
`H_L^G(γ_j)`; §13.10 says the same of the one-sided Fourier autocorrelation
matrix). So (T) as posed is a transfer/consistency theorem, not a route to RH —
as §11 says.

But your [1], Alpöge–Furman (arXiv 2608.13637v2), states its mechanism as:

> *"the Riemann hypothesis, classically needed to read the zero side as a
> positive sum over real ordinates, is replaced by a **rank–trace inequality
> applied to a finite compression of Weil's Hermitian form**, with **Sylvester's
> law of inertia handling off-line pairs**."*

That is precisely the hypothesis you need to remove, removed — on a finite
compression of the same form. And you already have the off-line inertia side:
Prop 7.1 (rank and inertia of the paired off-line matrix) and Thm 8.4 (real
parameter → positive rank-two, nonreal pair → indefinite rank-four).

**So:** can a rank–trace inequality on `S_{N,L}` bound the number of off-line
quartets directly, giving an *unconditional inertia statement* in place of a
*conditional convergence statement*? Concretely — does rank/trace/Hilbert–Schmidt
control on `S_{N,L}`, with Sylvester applied to your quartet structure, yield a
bound on `#{off-line zeros}` at finite `N`?

§6.1 notes your decomposition is "analogous in spirit" to theirs and identifies
the difference (interpolation annihilates the finite block exactly, so the
least-eigenvalue statement reduces to a scalar tail estimate). But that difference
concerns *ordinate recovery*. For the *inertia count*, the analogy may be
tighter than "in spirit" — and the inertia count is the direction that reaches RH.

**Caveat worth raising with you:** Lamzouri (2609.02882) subsequently reproved
the Alpöge–Furman bounds by replacing the entire finite-matrix framework with a
single Hilbert-space inequality plus Montgomery pair correlation — i.e. their
Weil-matrix scaffolding turned out to be removable, the content being pair
correlation. Do you expect the same deflation to apply to an inertia statement
for `S_{N,L}`, or does the divided-difference / rank-two-commutator structure
carry information pair correlation does not?

---

## Q2 — The metric data your own protocol requires, but the paper does not print

§10.8 mandates that the moving-dimension table contain
`λ_min(G₊)`, `λ_min(G₋)`, `κ(G₊)`, `κ(G₋)`, `μ₁, μ₂, μ₃`. The published table
(§4.6) reports only `λ₁`, `λ₂−λ₁`, `|δ*ê|`, `q⁻¹`.

**What are `λ_min(G±)` and `κ(G±)` at `N = L ∈ {2,5,7,11,13}`?**

This is not bookkeeping — it decides how hard requirement (c) is. Prop 4.4
brackets `g·q² ≤ λ_min(G) ≤ M·q²`. From your table:

| `N=L` | `g·q²` (floor) | `q²` |
|---|---|---|
| 7 | 8.72e−65 | 1.51e−33 |
| 11 | 1.38e−110 | 1.79e−56 |
| 13 | **6.81e−135** | 1.17e−68 |

The bracket spans ~66 orders of magnitude at `N=13`. If the measured
`λ_min(G±)` sits near `M·q²`, requirement (c) is hard but plausible; if it sits
near `g·q²`, it is hopeless in this parametrization. **The paper contains the
number that decides this and does not report it.**

---

## Q3 — Is there a family with unconditional positivity to build the inertia count on?

§13.10 draws a distinction you do not develop:

- Hermitian raised-cosine **product** matrices — *"pointwise positive
  semidefinite of rank at most two"* — apparently **unconditional**;
- the one-sided Fourier autocorrelation matrix — *"positive semidefinite **under
  the Riemann hypothesis**"*;
- symmetrized raised-cosine **convolution** matrices — *"real symmetric but
  generally indefinite"*.

Remark 13.6 ranks families by orthogonality, decay, rationality, positivity,
structure, cutoff, support — i.e. for *eigenvalue recovery*.

**Which family would you choose for a positivity-certification program instead?**
Is there one where enough positivity is unconditional that the Q1 inertia count
becomes tractable, while retaining the divided-difference structure and rank-two
commutator that make the pencil Hermitian?

---

## Q4 — The 2025–26 truncation literature appears to be missing

Your [4] is Connes 1999 (Selecta). Not cited, and all doing closely related work:

| | |
|---|---|
| **2511.22755** Connes–Consani–Moscovici, *Zeta Spectral Triples* | Rank-one perturbations of the scaling-operator spectral triple on `[λ⁻¹,λ]`, **Euler products over `p ≤ λ²` only**; spectra match low zeros; state that proving convergence would establish RH. The same reduction as yours, different truncation. |
| **2511.23257** Connes–van Suijlekom (CMP 2025) | Carathéodory–Fejér-type theorem: for the truncated Weil form at cutoff `c`, the ground state's zeros **provably lie on the critical line for every finite `c`**. |
| **2606.09096** Suzuki | Unifies Yoshida, **Bombieri (2001, 2003)**, Connes–Consani and CCM via the screw function, and brings **de Branges spaces** into the Weil-form analysis — you cite de Branges at [5] but not this. Conjectures a self-adjoint operator as the `a→∞` limit on `[−a,a]`. Structurally your (T) with a different truncation. |
| **2605.20224**, **2607.02828** Groskin | Numerics for the CvS/CCM truncation, and — most relevant — an exact finite **Guinand–Weil dictionary** plus a **two-sided certification rule** with explicit budget `B_T ≈ (2N+1)ρ log T/(π²T)`: finite-cutoff positivity certifies cutoff-free positivity; an eigenvalue below `−B_T` certifies a cutoff-free negative; one in `[−B_T, 0)` certifies nothing. |

**Deliberate (genuinely different framework) or not yet seen?** The Groskin
certification calculus looks directly portable to your setting and is exactly
what your framework lacks — a rule saying when a finite computation certifies a
cutoff-free conclusion. Your §10.9 pass–fail protocol is the right shape for it.

Also worth your attention: Groskin reports the same pathology independently —
spectral scale `10⁻⁵⁹` at cutoff `c=100`, needing `T ~ 10⁶³` to resolve by brute
force. Your `λ₁ ~ 7×10⁻⁷¹` at `N=13`. Two unrelated finite-Weil constructions
hitting `10⁻⁶⁰…10⁻⁷⁰` at comparable truncation size suggests the
ill-conditioning is intrinsic to finite Weil data rather than an artifact of
either parametrization. Does that match your view?

---

## Q5 — Lemke is a private communication

[2] Sören Lemke, *From Truncated Weil Arithmetic to a Finite Real Spectrum*,
private communication (2026), is load-bearing: the §4.6 projector diagnostic,
the §4.8 comparison, and the headline §11 verification (Lemke's quotient and the
contrast pencil agreeing to ≥ 62 decimal places at `N=L=13`) all rest on it.

**Is it available, or is a preprint planned?** As it stands the central
verification claim is not independently reproducible.

## Q6 — Code and failure reports

§10.9 insists every failure stay in the output: *"A calculation should not be
reported as a verification if a failed definiteness test or a large residual has
merely been suppressed."* Right standard.

**Are the §10.9 reports and the code available? Has any `(N,L)` actually failed
the definiteness test, or produced `G±` not positive definite?** Negative results
here are more informative than the `N=13` success.

---

## Q7 — Technical shape of Eq. 4.51

(a) **Is the `z`-uniformity essential?** Would separate bounds on
`‖(G⁰)^(−1/2) ΔG (G⁰)^(−1/2)‖` and `‖(G⁰)^(−1/2) ΔK (G⁰)^(−1/2)‖` suffice, or
does the argument genuinely need `sup_{|z|≤R}` of the combination?

(b) **What coupling `L = L(N)` do you expect?** Thm 6.1 needs only
`2πN/L < γ₁`, i.e. `L > 2πN/γ₁ ≈ 0.445 N`, and your table takes `L=N`. Does a
proof of (a) need `L ≫ N`? §5.7 notes all nodes `ν_{n,L}` move with `L`, so the
coupling is not free.

(c) Fitting your table gives `log₁₀ q ≈ −2.79 N` (steepening: per-`N` slope runs
−1.67 → −2.61), so the `(G⁰)^(−1/2)` sandwich carries amplification
`q⁻² ≳ 10^(5.6 N)`, already `~1.5×10⁶⁷` at `N=13`. **Do you see a route that
avoids paying `q⁻²`** — e.g. working in the exact orthogonal complement of the
interpolation null vector, which Thm 5.2 and Eq. 6.20 give in closed form? Our
reading is that this buys conditioning but not asymptotics, since `g` is itself
collapsing (`5.8×10⁻⁶⁷` at `N=13`).

## Q8 — Eq. 6.21 slack

We recomputed your bounds against true ordinates (mpmath, 60 dps, tail summed to
`j=400` plus the Riemann–von Mangoldt integral). **Eq. 6.21 holds at every `N`
you report** — your product-geometry explanation checks out:

| `N` | reported `λ₁` | Eq. 6.21 | Eq. 6.9 |
|---|---|---|---|
| 5 | 2.6600e−24 | 2.55e−20 | 0.0431 |
| 11 | 1.0679e−58 | 1.98e−51 | 0.0140 |
| 13 | 7.2193e−71 | 1.19e−62 | 0.0110 |

Two observations:

1. Eq. 6.9 is ~69 orders of magnitude loose at `N=13` — it cannot be what anyone
   cites as evidence for `λ₁ → 0`. Worth saying explicitly in the paper.
2. Eq. 6.21 is loose by ~8 orders at `N=13` and **widening** with `N`. The
   `Q_N/P_{N,L} ≤ 1/t` step (Eq. 6.14) discards the whole product
   `Π (t²−γ_j²)/(t²−ν_{j,L}²) < 1`. **Is there a sharper form retaining it?** A
   tight version would matter, since (a) needs exponentially sharp tail control.

---

## What we would send along

- `scripts/verify_shi.py` — the Eq. 6.21 / 6.9 recomputation above.
- The Prop 4.4 bracket table (Q2) computed from his own §4.6 data.
- Pointers to 2607.02828 (certification calculus), 2511.22755, 2606.09096.

## Priority if only one question gets answered

**Q1.** It is the difference between a conditional consistency framework and a
route to RH, and the tool is in a paper he already cites.
