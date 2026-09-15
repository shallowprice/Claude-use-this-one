# The Riemann Hypothesis — absolute state of the problem

Trace date **2026-09-15**. Every arXiv ID below was verified against the arXiv
API in-session; nothing here is from recollection. Claims I could not verify are
marked **[unverified]**.

RH is **open**. 167 years. No credible proof exists.

---

## 0. The shape, in one page

The problem has three live bands. They share vocabulary — Weil's explicit
formula appears in all three — but they do **not** share load-bearing machinery,
and none is close to closing.

| Band | What it does | Status |
|---|---|---|
| **I. Analytic** | Unconditional quantitative bounds on zeros | Moving fast. Two records broken since 2024. Cannot reach RH by design. |
| **II. Spectral / Weil-positivity** | Self-adjoint operators whose spectra are the zeros | **Converged on one shape in 2026.** RH reduced to a limit statement. The limit is the whole problem. |
| **III. Absolute geometry (`F_1`)** | Build the curve Weil's proof needs | Real structural progress, contact with perfectoid geometry. No closing statement. |

**The single most important development of the last ten months:** three
independent programs — Connes–Consani–Moscovici, Suzuki, and Shi — have
independently arrived at the *same* reduction. Build finite-rank self-adjoint
operators from Weil's explicit formula; their spectra approximate the zeros with
extraordinary accuracy; RH follows if and only if a certain limit converges.
Suzuki (2606.09096) explicitly unifies these under one operator-theoretic roof.

**Why this is less than it sounds.** Positivity at every finite level is now a
*theorem*. Positivity in the limit is *RH-equivalent and unproved*. The
difficulty was relocated, not reduced — and §4.4 collects four specific,
quantified reasons to think the relocation made it no easier.

---

## 1. What is actually proved about the zeros

Hard facts, unconditional:

- Infinitely many zeros lie on the critical line (Hardy, 1914).
- **> 67.25%** of zeros are simple *and* on the critical line (2026, §6).
- ≥ 83.62% of zeros are distinct; ≥ 88.76% are simple or critical or both
  (Lamzouri, 2609.02882).
- **Zero-free region:** `ζ(σ + it) ≠ 0` for `t ≥ 3`, `σ ≥ 1 − 1/(4.896 log t)`
  (Bellotti–Trudgian–Yang, 2603.21490, drawing on Heath-Brown's work on Linnik's
  constant). Note the shape: this is a *log* region. It does not approach `1/2`.
- **Computational verification:** RH true up to height `3 × 10^12` — precisely
  `3,000,175,332,800`, covering the lowest **12,363,153,437,138** zeros
  (Platt–Trudgian, 2004.09765, BLMS 2021; rigorous interval arithmetic).
- **de Bruijn–Newman constant:** `0 ≤ Λ ≤ 0.22`. Lower bound by Rodgers–Tao
  (1801.05914); upper bound by Polymath15 (1904.12438), improving Ki–Kim–Lee's
  `Λ < 1/2`. **RH ⟺ Λ ≤ 0**, hence RH ⟺ Λ = 0.

That last item deserves emphasis. Rodgers–Tao's proof works by showing that
`Λ < 0` would force the zeros into local equilibrium — locally equally spaced —
which contradicts Montgomery's pair correlation. So **if RH is true, it is true
by the narrowest possible margin.** There is no slack in the system. Any proof
strategy that would give `Λ < 0` is dead on arrival.

---

## 2. Band I — analytic, unconditional, quantitative

### 2.1 Zero density
Guth–Maynard (2405.20552, 2024): a new large-values estimate for Dirichlet
polynomials of length `N` at size `≈ N^{3/4}`, giving

    N(σ, T) ≤ T^{30(1−σ)/13 + o(1)}

the **first improvement on Ingham's 1940 exponent in 80+ years** for real parts
up to 3/4. Consequence: primes in short intervals of length `x^{17/30 + o(1)}`.
Survey: Turnage-Butterbaugh, 2607.04632.

### 2.2 Moments and random matrix theory
- Proved: 2nd moment (Hardy–Littlewood), 4th moment (Ingham). Beyond that,
  only bounds.
- CFKRS / Keating–Snaith give conjectural asymptotics for all moments, matched
  to characteristic polynomials of random unitary matrices. The GUE
  correspondence for pair correlation (Montgomery–Odlyzko) is numerically
  overwhelming and remains conjectural.
- Arguin–Creighton (2603.01711) prove unconditional lower bounds on real large
  deviations of order `V ≈ α log log T`, recovering the sharpest known
  unconditional lower bounds on fractional moments, matching in order the upper
  bound for `0 < α < 2`.

### 2.3 Why this band cannot reach RH
By construction. Zero-density and proportion results are *counting* statements;
they bound exceptions. Pushing the proportion to 100% is not RH (RH needs
*every* zero, and "100% in density" permits infinitely many exceptions). The
zero-free region is logarithmic and has no mechanism to reach `σ = 1/2`. This
band is where unconditional progress happens, and it is not a route.

---

## 3. Band II — the spectral convergence. This is the frontier.

### 3.1 The classical spine
- **Weil explicit formula:** sum over zeros = archimedean term + prime terms.
- **RH ⟺ Weil positivity** of the associated quadratic form on adelic test
  functions. An equivalence — difficulty is conserved, not reduced.
- Weil *proved* the function-field analogue via intersection theory on `C × C`
  (Castelnuovo–Severi positivity); Deligne generalized.
- **Connes (1998):** trace formula on the adele class space `A_Q/Q^×`, zeros as
  an absorption spectrum. RH ⟺ trace formula ⟺ Weil positivity.
- **Meyer (2005):** made the spectral realization rigorous.
- **Hilbert–Pólya:** find a self-adjoint operator whose eigenvalues are the
  `γ_k`. Never found. Berry–Keating and related quantizations remain heuristic.

### 3.2 The 2026 convergence — three programs, one shape

**(a) Connes–Consani–Moscovici — *Zeta Spectral Triples* (2511.22755).**
Rank-one perturbations of the spectral triple of the scaling operator on
`[λ^{-1}, λ]`, built **only from Euler products over `p ≤ x = λ²`**. Spectra
match the low zeros of `ζ(1/2 + is)` with striking accuracy even at small `x`.
Their own words: *"A rigorous proof of this convergence would establish the
Riemann Hypothesis."* Regularized determinants appear to converge to `Ξ`.

**(b) Suzuki — screw function / de Branges (2606.09096, June 2026).**
A unified operator-theoretic framework covering Yoshida (1992), **Bombieri
(2001, 2003)**, Connes–Consani (2023) and CCM (2025+), via the screw function
(Suzuki 2023, 2301.00421). Its advantage: the Weil quadratic form, originally
distributional, becomes accessible through *continuous functions*, and **de
Branges space theory** enters via the Fourier transform. Suzuki conjectures that
a self-adjoint operator with the `γ_k` as eigenvalues arises as the limit
`a → ∞` of self-adjoint operators from nonlocal realizations of the first-order
differential operator on `[−a, a]`. **All obtained without assuming RH.** He
explicitly compares this to the CCM limit formula.

**(c) Shi — finite Hilbert–Pólya matrices (2609.04908, Sept 2026).**
From the `Ξ`-specialization of Weil's explicit formula, constructs finite
real-symmetric Prime–Weil matrices from pole, archimedean and prime-power data;
off-diagonal entries form a Loewner-type divided-difference matrix with a
rank-two displacement identity.

### 3.3 The rigor layer — and the numbers that matter

**Finite-level reality is a theorem.** Connes–van Suijlekom (2511.23257, CMP
2025): for a real distribution whose quadratic form is lower-bounded self-adjoint
with simple isolated lowest eigenvalue and even eigenfunction `ξ`, **all zeros of
`ξ̂` are real.** Step 1 is a C*-algebraic proof of a **Carathéodory–Fejér (1911)**
corollary: Hermitian PSD Toeplitz `T ∈ M_n(C)` of rank `n−1`, `ξ ∈ ker T` ⟹
`P(z) = Σ ξ_j z^j` has all zeros on the unit circle. Steps 2–4 extend to
convolution kernels and to the matrix structure appearing in **spectral action**
expansions; step 5 is Hurwitz. Consequence: for the truncated Weil form at prime
cutoff `c`, the ground state's zeros provably lie on the critical line, **every
finite `c`**.

**Connes' own demonstration** (2602.04022): extremizing a restriction of Weil's
quadratic form **using only primes below 13** approximates the first 50 zeros to
between `2.6 × 10^{-55}` and `10^{-3}`, and he proves the approximants lie
exactly on the critical line.

**Independent numerics** (Groskin, 2605.20224): 16 cutoffs `c = 13 … 100`.
First-zero error falls monotonically `~2×10^{-55} → ~1.5×10^{-168}` across
`c = 13…67` at `N = 100`; smallest-positive even-sector eigenvalue `~10^{-334}`
at `c = 100, N = 250`, whose eigenvector recovers `γ_1 … γ_10` to 307–329
matching digits.

**The certification theorem** (Groskin, 2607.02828) — the most useful single
result for anyone working here. Two exact finite theorems:
1. Every real even Galerkin coefficient vector `v` determines in closed form a
   band-limited Guinand–Weil test function `g_v` whose zero-sum over the
   nontrivial zeros equals `⟨v, Qv⟩` **exactly**. Every value of the truncated
   form is an exact sum over the zeros.
2. Beyond the Galerkin band the omitted archimedean tail is a totally positive
   Cauchy–Stieltjes increment, giving a **two-sided certification rule** with
   explicit budget `B_T ≈ (2N+1) ρ log T / (π² T)`, `ρ = 2π / log c`:
   - finite-cutoff positivity ⟹ **cutoff-free positivity certified**;
   - an eigenvalue below `−B_T` ⟹ **cutoff-free negative certified**;
   - an eigenvalue in `[−B_T, 0)` ⟹ **certifies nothing**.

   Verified over the first 512 zeros by three independent computational routes.

### 3.4 Where the difficulty actually sits — four hard barriers

Do not read the finite-level theorems as partial progress toward the limit.

**(i) The limit is the entire problem.** Finite-level reality is proved;
convergence as `c → ∞` is open and is exactly RH. Continuum positivity of `QW_λ`
is RH-equivalent and is *not* assumed at finite cutoff.

**(ii) Scale catastrophe.** Groskin (2607.02828): resolving a spectral scale of
`10^{-59}` at `c = 100` by brute cutoff would require `T ~ 10^{63}`. The relevant
quantities shrink superexponentially in the cutoff. Any approach that hopes to
see the limit numerically is dead; only exact/interval methods (he uses a
cutoff-free LDL^T factorization) reach it.

**(iii) Extrapolation is already falsified once.** Groskin's own empirical rate
`|log₁₀ λ_min| ≈ 13.24 c^{0.634}` (fit on `c ≤ 67`, `N = 100`) **fails at
`c = 100, N = 200` by 49 orders of magnitude.** Finite-`N` behaviour is not a
guide to true asymptotics. Treat every "the numerics clearly converge" claim in
this area with that in mind.

**(iv) Reconstruction, not prediction.** Shi (2609.04908) is admirably explicit:
*"Since the ordinates are inputs, this is a reconstruction theorem."* The finite
Hilbert–Pólya matrices are built **from** the zeros. They reproduce `γ_1, γ_2,
γ_3` at `N = L = 13`, but they cannot predict what they were given. He names the
remaining gap precisely: *a relative prime-to-zero perturbation theorem with
uniform control of the compressed metric.* That is the honest open problem.

A fifth, structural warning from the numerical realization of **Suzuki's**
operator (Kim et al., 2607.24830): **(R4) the nontrivial zeros are *not*
eigenvalues** — they appear in the explicit-formula error term of the prime
symbol. The archimedean spectrum obeys a clean closed law
`A_k(a) = log(1/a) + log(k−2) + B_0 + O(a)` to 30 digits, total spectral
intensity follows PNT, and Weil positivity does appear in operator form (bounded
residual growth ⟺ all zeros on the line; an injected off-line zero causes
exponential blow-up). But the authors state plainly that the significance is
*"faithful numerical realization of classical identities rather than new
arithmetic."* The operator knows the archimedean place beautifully and the zeros
only indirectly.

---

## 4. Band III — absolute geometry, building the missing curve

- **2602.15941** *On the Jacobian of `Spec Z`-bar* — adele class space (Riemann
  sector) as the monoidal extension of `Pic` of the arithmetic curve; elements
  are torsion-free rank-1 abelian groups with rigidifying data (a norm, extending
  Arakelov metrized line bundles; for the full space, a morphism to `R` plus a
  parametrization of roots of unity). Incorporates the **singular strata required
  for spectral realization of L-functions**.
- **2606.06604** *On the Absolute Geometry of `Spec Z`* — constructs
  `(Spec Z)_{F_1}`; geometric realization of Scholze's untilt heuristic. At each
  `p`, non-trivial complex points form torsors over the Weil groups
  `W_p = Q_p^×`, `W_∞ = C^×`; quotienting the archimedean orbit by discrete
  Frobenius gives the complex **Tate curve** with modulus `q = p^{-1}`, which
  decomposes as its real locus — exactly the adelic periodic orbit
  `C_p = R_+^×/p^Z` — times a `p`-independent phase space that is a **real
  analogue of the Fargues–Fontaine curve**.
- **2609.00299** *The Absolute Twistor Line* — archimedean component over the
  signed extension `F_{1²}`; equivariant topos with geometric inversion symmetry
  inducing the twistor real structure; pericyclic λ-operations interpret local
  factors of geometric L-functions.

Earlier spine: Riemann–Roch for `Spec Z`-bar (2205.01391) and for `Z`
(2306.00456); spectral triples and ζ-cycles (2106.01715); BC-system and absolute
cyclotomy (2112.08820); knots/primes/adele class space (2401.08401, 2501.06560);
semilocal prolate operator and Sonin space (2310.18423).

**Assessment.** This band now has an archimedean component and genuine contact
with perfectoid / Fargues–Fontaine geometry — it did not five years ago. It does
**not** have a Riemann–Roch or positivity statement that closes Weil's argument
over `Z`. Whether Band II and Band III converge is the thing to watch.

---

## 5. The structural obstruction

Connes' own diagnosis (essay, 1509.05576) of why the function-field proof does
not transfer:

1. **No curve.** Number fields lack the geometric object Weil exploited.
2. **No Frobenius.** The characteristic-`p` Frobenius, central to the argument,
   has no direct analogue.
3. **No self-product.** Intersection theory on `C ×_{F_q} C` cannot be
   replicated — there is no `Spec Z ×_{F_1} Spec Z`.

His conclusion is that the adelic/NCG approach has not closed because the missing
geometric framework has not been reconstructed. **The obstruction is structural,
not computational.** Band III is the direct attempt to remove it; note that its
2026 papers are building exactly these three missing objects.

---

## 6. The AI contributions — factual state

**The 67.25% result.** In August 2026 an internal research version of Claude
(Anthropic) proved unconditionally that **> 67.250%** of non-trivial zeros are
simple *and* on the critical line — the previous unconditional record was 41.6%
(Pratt–Robles–Zaharescu–Zeindler 2020, after Conrey's 40.77% in 1989).

Method: a function space carrying the **Weil-induced quadratic form**; positive-
and negative-definite subspaces for on- and off-line zeros; a **rank–trace
inequality** for Hermitian matrices; a second-moment calculation over the zeros
via the explicit formula. The decisive move was treating the whole space at once,
positive and negative parts jointly, with the form allowed to be **non-diagonal**.
Inputs: Aryan; Baluyot–Goldston–Suriajaya–Turnage-Butterbaugh; Bombieri (2000).

Verification chain, unusually strong: internal review (Levent Alpöge, Ralph
Furman); numerical testing; **external review by Brian Conrey and Dan Goldston**
— the authors of the records it broke; a **Lean formalization** (with Eric
Easley) passing the standard validator; and an independent re-derivation by
**Lamzouri (2609.02882)** which adds two estimates the AI paper does not contain.
It checks out.

**But read Lamzouri's method.** He replaces *the entire finite-dimensional matrix
framework* with a single Hilbert space inequality, enabling direct application of
Montgomery's pair correlation theorem in the unconditional form of
Baluyot–Goldston–Suriajaya–Turnage-Butterbaugh. The Weil-form scaffolding was
**removable**; the content was pair correlation. Anthropic states plainly: *"We
don't expect that the techniques Claude used will lead to proving the Riemann
hypothesis."*

**Net.** A real theorem and a large jump in Band I. It is **not** evidence that
finite-rank Weil truncations carry positivity into the limit — if anything it is
mild evidence against, since the one place a finite-rank Weil form produced
unconditional arithmetic, the form turned out to be dispensable.

For context: conditionally, Baluyot–Goldston–Suriajaya–Turnage-Butterbaugh
(2501.14545) reached 2/3 assuming zeros lie in a narrow box of width
`b/log T`, `b = 0.3185`; Goldston–Suriajaya (2511.20059) showed that removing RH
from Montgomery's simple-zero argument would give 2/3 simple and critical.

---

## 7. Formalization status

- **PNT formalized in Lean 4** — `PrimeNumberTheorem+` (Kontorovich, Tao), via
  Wiener–Ikehara; and a version with error term stronger than previously
  formalized.
- **ζ and Dirichlet L-functions in Mathlib** (2503.00959, Annals of Formalized
  Mathematics) — including Dirichlet's theorem and a **formal statement of RH**.
- Further Lean work reports the de la Vallée Poussin zero-free region, PNT with
  classical exponential remainder, **Hardy's theorem**, the all-height
  Riemann–von Mangoldt counting formula, and Carlson's zero-density estimate.
  **[unverified — from a repository description, not a refereed source]**

**Implication for us:** the finite-dimensional, load-bearing piece of Band II —
the **Carathéodory–Fejér corollary** (PSD Toeplitz of rank `n−1` ⟹ kernel
polynomial has all zeros on the unit circle) — is squarely formalizable, and
Mathlib now has enough spectral-theory and polynomial infrastructure to attempt
it. That remains the highest-leverage formalization target in this whole map.

---

## 8. Honest distance to a proof

- Band I is advancing and structurally cannot finish.
- Band II has a clean reduction, three independent realizations, a certification
  calculus, and **four quantified reasons** (§3.4) why the remaining gap is not
  small. The nameable open problems are: CCM's convergence; Suzuki's `a → ∞`
  limit conjecture; Shi's *relative prime-to-zero perturbation theorem with
  uniform control of the compressed metric*.
- Band III is building the three objects Connes names as missing, and has not
  reached a positivity statement.
- `0 ≤ Λ ≤ 0.22` says there is no margin anywhere in the problem.

Nobody has a proof and nobody credible claims one. The 2026 change is that the
target is better-posed than it was in 2019 — three groups can now write down the
same missing lemma.

---

## 9. Source hygiene

The RH literature is heavily polluted. Ordinary web search on this topic returns
claimed proofs on ResearchGate, PhilArchive, Medium, Zenodo and alphaXiv, plus
material invoking invented apparatus ("Large Cardinal Theorem of Analytic
Completeness", "Λ-obstruction") that does not exist. **None of that is cited
here.** Everything above traces to arXiv IDs verified in-session, refereed
venues (BLMS, CMP, Enseign. Math.), or Anthropic's own published statement.

Note also that several Band II numerics papers are single-author and not
obviously refereed (Groskin 2605.20224, 2607.02828; Shi 2609.04908; Kim et al.
2607.24830). They are *unusually careful* — each explicitly disclaims proving RH,
ships scripts, and states its own failure modes — and their content is checkable
computation, which is why they are here. Weight them as verifiable numerics and
honest bookkeeping, not as theory.

---

## 10. Open thread

**"Local-to-global, Mercuri route"** — searched; no such named approach appears
in the literature or on arXiv. Treating this as internal terminology pending
clarification, along with the compiled non-axiomatic Lean files and the model
design, per the agreement to set our own work aside for now.

---

## Sources

**Band I:** 2405.20552, 2607.04632, 2603.21490, 2004.09765, 1801.05914,
1904.12438, 2603.01711, 2501.14545, 2511.20059, 2609.02882.

**Band II:** 2511.22755, 2511.23257, 2602.04022, 2605.20224, 2607.02828,
2606.09096, 2301.00421, 2609.04908, 2607.24830, 2310.18423, 2106.01715.

**Band III:** 2602.15941, 2606.06604, 2609.00299, 2205.01391, 2306.00456,
2112.08820, 2401.08401, 2501.06560.

**Obstruction:** 1509.05576.  **Formalization:** 2503.00959.
**AI result:** https://www.anthropic.com/research/riemann-zeta + 2609.02882.
