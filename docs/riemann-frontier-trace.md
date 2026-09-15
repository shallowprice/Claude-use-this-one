# The Riemann Frontier — trace of 2026-09-15

Status map of where the Riemann Hypothesis actually stands, with the adelic /
noncommutative-geometry line traced in detail. Sources are arXiv IDs, verified
against the arXiv API on the date above (not from memory).

---

## 0. One-paragraph shape

RH is open (167 years). The frontier has three bands that are **not** converging
on each other. The **analytic band** produces unconditional quantitative
results and has moved hard in the last two years (Guth–Maynard; the critical-line
proportion jumping 41.7% → 67.25%). The **adelic/spectral band** (Connes and
collaborators) has, in the last ten months, been compressed into a single
analytic statement — convergence of finite-Euler-product spectra to the zeta
zeros — with the finite-level positivity now a *theorem*. The **absolute-geometry
band** (`F_1`, `Spec Z`-bar) is building the object Weil's function-field proof
needs, and is not yet at a statement that closes. The bands share vocabulary
(Weil's quadratic form) but not load-bearing machinery.

---

## 1. Analytic band — unconditional, quantitative

### 1.1 Zero density
Guth–Maynard (2024, arXiv 2405.20552) proved a new large-values estimate for
Dirichlet polynomials of length `N` near size `N^{3/4}`, yielding

    N(σ, T) ≤ T^{30(1−σ)/13 + o(1)}

the **first improvement on Ingham's 1940 exponent in over 80 years** in the
range of real parts up to 3/4. Consequence: asymptotics for primes in short
intervals of length `x^{17/30 + o(1)}`.

Survey placing it in context: Turnage-Butterbaugh, arXiv 2607.04632.

### 1.2 Proportion of zeros on the critical line

| Year | Result | Author |
|---|---|---|
| 1974 | > 1/3 (then 0.3474) | Levinson |
| 1989 | > 40.77% | Conrey |
| 2020 | > 41.72%, simple | Pratt–Robles–Zaharescu–Zeindler |
| 2025 | 2/3, **conditional** on zeros in a narrow box (b = 0.3185) | Baluyot–Goldston–Suriajaya–Turnage-Butterbaugh (2501.14545) |
| 2026-08 | **> 67.25%, simple and on the line, unconditional** | Claude (Anthropic) |
| 2026-09 | same bound, simpler proof; + 83.62% distinct, 88.76% simple-or-critical | Lamzouri (2609.02882) |

This is the largest single jump in the sequence, and it broke a bound that had
stood in the low 40s since 1989.

---

## 2. The AI work — does it check out?

**Yes, with a precisely bounded scope.** This is the strongest-verified recent
result in the table.

**What was proved.** At least 67.250% of the non-trivial zeros of ζ are *both*
simple *and* on the critical line, unconditionally, in the usual asymptotic
sense. Previous unconditional record: 41.6%.

**Method** (per Anthropic's write-up and Lamzouri's description):
- a function space carrying the **quadratic form induced by Weil**;
- positive- and negative-definite subspaces representing zeros on / off the line;
- an inequality relating the **rank** of the quadratic form to moment information
  (a rank–trace inequality for Hermitian matrices);
- a second-moment calculation over the zeros via the **explicit formula**;
- the crucial move: treating the whole space at once, positive and negative parts
  **together**, with the form allowed to be **non-diagonal**.
- Inputs: Aryan; Baluyot–Goldston–Suriajaya–Turnage-Butterbaugh; Bombieri (2000).

**Verification chain** — unusually thorough for a two-month-old result:
1. internal review by two mathematicians (Levent Alpöge, Ralph Furman);
2. independent numerical testing against known zeros;
3. external review by **Brian Conrey and Dan Goldston** — i.e. by the authors of
   the records it broke;
4. a **Lean formalization** (with Eric Easley) that passes the standard validator;
5. independent re-derivation: Lamzouri (2609.02882) reproves the bound by a
   different route and *adds* two estimates the AI paper does not contain.

That is a real check, not a press release.

### 2.1 The part that matters for the adelic line

Claude's argument ran through a **finite-dimensional matrix representation of
Weil's Hermitian form** — the exact object at the centre of the Connes program.
So it is a genuine proof-of-concept that the Weil form, handled at finite rank
with the positive and negative parts treated jointly and non-diagonally, yields
unconditional arithmetic output rather than another reformulation.

**But read Lamzouri carefully, because it cuts the other way too.** He replaces
"the entire finite-dimensional matrix framework by a single Hilbert space
inequality," letting him apply Montgomery's pair-correlation theorem in the
unconditional form of Baluyot–Goldston–Suriajaya–Turnage-Butterbaugh. That means
the Weil-form scaffolding was **removable**: the mathematical content was pair
correlation, not adelic positivity. The finite-rank Weil form was doing
bookkeeping, not lifting.

Anthropic states this directly: *"We don't expect that the techniques Claude used
will lead to proving the Riemann hypothesis."* Take that at face value.

**Net for our purposes:** it checks out as a theorem, and it is *evidence against*
the hope that finite-rank truncations of the Weil form carry positivity
information toward the limit. That is a real clarification — a negative one, and
worth having.

---

## 3. Adelic line — the actual frontier

### 3.1 The classical spine
- **Weil explicit formula:** sum over zeros = archimedean term + prime terms.
- **RH ⟺ Weil positivity** of the associated quadratic form on adelic test
  functions. This is an equivalence, not a simplification — all difficulty is
  conserved.
- Weil *proved* the function-field analogue via intersection theory on `C × C`
  (Castelnuovo–Severi positivity). The transfer obstruction is concrete: over
  `Z` there is no curve and no self-product `Spec Z ×_{F_1} Spec Z`.
- **Connes (1998):** trace formula on the adele class space `A_Q / Q^×`, with
  zeros realized as an absorption spectrum. RH ⟺ trace formula ⟺ Weil positivity.
- **Meyer (2005):** made the spectral realization rigorous.

### 3.2 What changed in the last ten months — the compression

This is the news, and it is a genuine change of shape.

**(a) Finite-level positivity is now a theorem.**
Connes–van Suijlekom, *Quadratic Forms, Real Zeros and Echoes of the Spectral
Action* (arXiv 2511.23257, Commun. Math. Phys. 2025). For a real distribution `D`
on `[0, L]` whose quadratic form is lower-bounded self-adjoint with simple
isolated lowest eigenvalue and even eigenfunction `ξ`, **all zeros of `ξ̂(z)` lie
on the real line.** Proof is five steps, the first being a C*-algebraic proof of a
corollary of **Carathéodory–Fejér (1911)**: a Hermitian PSD Toeplitz `T ∈ M_n(C)`
of rank `n−1` with `ξ ∈ ker T` gives `P(z) = Σ ξ_j z^j` with all zeros on the unit
circle. Steps 2–4 push this to convolution kernels and then to the matrix shape
that appears in **perturbative expansions of the spectral action**; step 5 is
Hurwitz.

Consequence: for the truncated Weil form at cutoff `c` (only primes `p ≤ c`), the
ground state's Fourier–Mellin zeros **provably lie on the critical line, for every
finite `c`**.

**(b) The strategy is now stated as an explicit reduction.**
Connes–Consani–Moscovici, *Zeta Spectral Triples* (arXiv 2511.22755). Rank-one
perturbations of the spectral triple of the scaling operator on `[λ^{-1}, λ]`,
built **only from Euler products over `p ≤ x = λ²`**, give self-adjoint operators
whose spectra match the low zeros of `ζ(1/2 + is)` with striking numerical
accuracy even at small `x`. Their own statement:

> *"A rigorous proof of this convergence would establish the Riemann Hypothesis."*

They further compute regularized determinants which, suitably normalized, appear
to converge to the Riemann **Ξ function**.

**(c) The survey confirms the same reduction.**
Connes, *The Riemann Hypothesis: Past, Present and a Letter Through Time*
(arXiv 2602.04022). Commissioned survey of 165 years, plus an original "Letter to
Riemann" using only 19th-century mathematics: extremizing a restriction of Weil's
quadratic form **using only primes < 13** approximates the first 50 zeros to
between `2.6 × 10^{-55}` and `10^{-3}`, and he *proves* the approximating values
lie exactly on the critical line. Final sections outline the proof strategy as
**convergence of zeros from finite to infinite Euler products**.

**(d) Independent numerics.**
Groskin, arXiv 2605.20224 (v4) — first public implementation of the CvS Galerkin
matrix, 16 cutoffs `c = 13 … 100`. First-zero error falls monotonically from
`~2×10^{-55}` to `~1.5×10^{-168}` across `c = 13…67` at `N = 100`; the
smallest-positive even-sector eigenvalue reaches `~10^{-334}` at `c = 100,
N = 250`, whose eigenvector recovers `γ_1 … γ_10` to 307–329 matching digits.
Status: single-author implementation/verification paper, explicitly **"We make no
claim of proof."** Treat as checkable numerics corroborating CCM, not as theory.

### 3.3 Where the difficulty now sits — read this carefully

The compression is real but the hard part is intact, and it is important not to
misread the finite-level theorems as partial progress toward the limit.

- Finite-level reality of zeros is **proved** (CvS / Carathéodory–Fejér).
- Convergence as `c → ∞` is **open** and is the whole of RH.
- **Continuum positivity of `QW_λ` is RH-equivalent and is not assumed** at finite
  `λ` — Groskin flags this explicitly. The finite truncations do not approach
  positivity uniformly; they are positive for reasons that do not survive the
  limit.
- Groskin's own empirical rate `|log₁₀ λ_min| ≈ 13.24 c^{0.634}` (for `c ≤ 67`,
  `N = 100`) is **falsified at `c = 100, N = 200` by 49 orders of magnitude** —
  i.e. the finite-`N` behaviour is not yet a guide to the true asymptotics. That
  is a warning sign about extrapolating the numerics.

So: the adelic line has moved from "reformulate RH as positivity" to "prove one
convergence statement," which is a better-posed target than it was in 2019. But
the difficulty was *relocated*, not reduced, and §2.1 above is independent
evidence that finite-rank Weil-form data does not obviously carry the limit.

---

## 4. Absolute-geometry branch — building the missing curve

Running in parallel, aiming at the object Weil's proof needs:

- **2602.15941** *On the Jacobian of `Spec Z`-bar* — the adele class space (and
  specifically its Riemann sector) read as the monoidal extension of `Pic` of the
  arithmetic curve; elements are torsion-free rank-1 abelian groups with
  rigidifying data (a norm in the Riemann sector — extending metrized line bundles
  in Arakelov geometry; for the full space, a morphism to `R` plus a
  parametrization of roots of unity). Incorporates the **singular strata required
  for spectral realization of L-functions**.
- **2606.06604** *On the Absolute Geometry of `Spec Z`* — constructs the absolute
  `F_1`-arithmetic curve `(Spec Z)_{F_1}`; gives a geometric realization of
  Scholze's untilt heuristic. At each prime `p`, non-trivial complex points form
  two torsors over the Weil groups `W_p = Q_p^×` and `W_∞ = C^×`; quotienting the
  archimedean orbit by discrete Frobenius yields the complex **Tate curve** with
  modulus `q = p^{-1}`, which decomposes as its real locus — exactly the adelic
  periodic orbit `C_p = R_+^× / p^Z` — times a `p`-independent phase space that is
  a **real analogue of the Fargues–Fontaine curve**.
- **2609.00299** *The Absolute Twistor Line* — amalgamates the affine absolute
  curve with an archimedean component over the signed extension `F_{1²}`, giving
  an equivariant topos with geometric inversion symmetry inducing the twistor real
  structure. On complex points the dynamics generates Adams operations and complex
  conjugation on real Hodge structures; the pericyclic category's λ-operations
  interpret local factors of geometric L-functions.

Earlier spine: Riemann–Roch for `Spec Z`-bar (2205.01391), for `Z` (2306.00456),
ζ-cycles / spectral triples (2106.01715), BC-system and absolute cyclotomy
(2112.08820), Knots–primes–adele class space (2401.08401, 2501.06560), the
semilocal prolate operator and Sonin space (2310.18423).

**Assessment:** this branch now has an archimedean component and a genuine
contact point with perfectoid/Fargues–Fontaine geometry, which it did not have
five years ago. It does not yet have a Riemann–Roch or positivity statement that
closes the Weil argument over `Z`. Convergence of branch 3 and branch 4 is the
thing to watch.

---

## 5. Our own adelic work — honest read

Files in the Drive `AdelicSolver` Lean project (`ModularLWE` namespace, ~24 files
incl. `Dynamical.lean`, `CuspidalSL2.lean`, `HeckeFrobenius.lean`,
`HeckeMonoid.lean`, `CondensedKMS.lean`, `MotivicEqualizer.lean`,
`V36Survivors.lean`, `HarmonicMaass/`).

Two files read in full this session:

**`AdelicOrderZero.lean`** — proves Connes' order-zero condition
`[a, J b* J^{-1}] = 0` for `C` and for `C × C`. **These are commutative rings**, so
`commutator_comm` closes everything by `simp [mul_comm]`. The docstring's claim
that the axiom is "fully decided" on the two-slot product is literally true and
mathematically empty: the real content of the order-zero axiom lives in the
**noncommutative** case, which this file does not touch. The final lemma
(`left_right_mul_assoc`) is the honest part — it isolates *why* left and right
actions commute — but it is a ring identity, not a model.

**`ProductFormulaR.lean`** — states the product formula as an **assumed field** of
a structure:

    product_formula : ∀ a : Rq n q, a ≠ 0 → ∑ v, degree v * logNorm v a = 0

The file says so plainly: *"This is an interface, not a construction"*, source
Artin reciprocity. The two theorems (`arch_determined`, `arch_unique`) are
one-line consequences (`Finset.add_sum_erase` + `linarith`) — correct, but a
definitional rearrangement, not content.

**Verdict.** The Lean work is *honestly labelled*, which puts it well above the
usual run of machine-generated mathematics — the assumptions are marked as
assumptions and the trivial cases are marked as trivial. But it is scaffolding:
everything load-bearing sits in assumed interfaces, and the proved content is
finite commutative-ring algebra. It is also, note, aimed at **Modular-LWE
cryptography** (pinning the archimedean head of a recovered secret so rounding
cannot move it freely), not at RH. That is a legitimate and quite different target
— worth keeping the two goals verbally separate.

---

## 6. Where the leverage is next

Ranked by ratio of tractability to value:

1. **Formalize the Carathéodory–Fejér corollary (CvS step 1) in Lean.** Finite-
   dimensional linear algebra: Hermitian PSD Toeplitz of rank `n−1`, kernel vector
   gives a polynomial with all zeros on the unit circle. This is *load-bearing*
   for the adelic line, it is genuinely formalizable, and Mathlib has most of the
   Toeplitz/PSD prerequisites. It would convert our scaffolding into a real
   contribution. **This is the recommendation.**
2. **Read the CCM convergence statement precisely** (2511.22755 §5, incl. Lemma
   5.1) and write down exactly what analytic estimate is missing. The reduction is
   stated; the missing lemma should be nameable.
3. **Reproduce Groskin's Galerkin numerics independently** at `c ≤ 67` and check
   the `c = 100` cutoff-artifact claim about negative-sign eigenvalues at `T = 800`.
   Cheap, and tests whether the corroboration is real.
4. **Track branch-3 / branch-4 convergence** — specifically whether the
   Fargues–Fontaine contact in 2606.06604 gives a positivity statement.

Not recommended: further order-zero files in the commutative case, and any
extension of the adelic-caustic LLM line as *evidence about* RH — that is an
architecture with number-theoretic motifs, not a probe of zeta.

---

## Sources

Adelic / NCG line: arXiv 2511.22755, 2511.23257, 2602.04022, 2602.15941,
2605.20224, 2606.06604, 2609.00299, 2310.18423, 2205.01391, 2306.00456,
2106.01715, 2112.08820, 2401.08401, 2501.06560.

Analytic band: arXiv 2405.20552, 2607.04632, 2609.02882, 2501.14545, 2511.20059,
2603.28104, 2306.04799.

AI result: https://www.anthropic.com/research/riemann-zeta ; arXiv 2609.02882.
