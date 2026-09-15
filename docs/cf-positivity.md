# Finite-level positivity: an elementary proof of Connes–van Suijlekom Corollary 1.1

Working notes, 2026-09-15. Source: **arXiv 2511.23257** (Connes–van Suijlekom,
*Quadratic Forms, Real Zeros and Echoes of the Spectral Action*, CMP 2025), read
in full. Numerical validation: `scripts/cf_check.py`, `scripts/cf_check2.py`.

---

## 1. Why this theorem is the right target

Recall the split from `docs/shi-transfer-problem.md`. Across all three Band II
programs, the statements that *assume* RH are consistency theorems; the
statements that could *prove* RH are positivity statements. Corollary 1.1 is on
the positivity side, and it is the engine that makes **finite-level positivity**
work in the CCM truncation:

> **Corollary 1.1 (CvS).** Let `T ∈ M_{n+1}(ℂ)` be Hermitian, positive
> semidefinite, Toeplitz, of rank `n`, and let `ξ ∈ ker T`. Then all zeros of
> `P(z) := Σ_{j=0}^{n} ξ_j z^j` lie on the unit circle.

CvS say exactly where the difficulty then goes, and it is worth quoting because
it is the honest statement of what this buys:

> *"In number theory, Toeplitz matrices of this kind naturally arise, and
> Corollary 1.1 applies to show that the zeros of the polynomial `P(z)`,
> associated to an eigenvector for the smallest eigenvalue of such a matrix, all
> lie on the unit circle. **The key difficulty in this context, then, becomes the
> verification that zero is indeed the (simple) minimal eigenvalue of `T`.**"*

They also note the resonance with the function-field case, and flag (Remark 2.3)
that **simplicity is essential**: if `ker T` has dimension > 1 the statement is
false as stated, and the correct version is that the *intersection* of the zero
sets of the various eigenfunctions lies on the circle — "reminiscent of the
radical of a quadratic form."

## 2. CvS's proof, and why it resists formalization

Their route (§2) is C\*-algebraic:

1. `A = ℂ[X, X^{-1}]` with involution `(aX^n)* = ā X^{-n}`; `J = (P)`.
2. `J* = J`, because `P` is palindromic or anti-palindromic — `ker T` is stable
   under `j ↦ n−j` by the Toeplitz structure, and is 1-dimensional, so the flip
   acts by `λ` with `λ² = 1`.
3. `{X^j}_{j<n}` is a basis of `A/J` (needs `ξ_0 ≠ 0`, via localisation of
   `ℂ[X]` at `X` commuting with quotients).
4. The functional `ϕ(X^j) = c_j` is well defined and **positive**, because
   `ϕ(f* f) = ⟨f | T f⟩ ≥ 0`.
5. `ϕ` extends to the enveloping C\*-algebra `C*(ℤ)`, i.e. a positive measure on
   `U(1)`; the GNS representation is `n`-dimensional; `P ∈ J ⊆ ker π`, so the
   roots of `P` are eigenvalues of the unitary `π(X)`, hence of modulus one.

Elegant, but for Lean it needs Laurent polynomials with involution, localisation,
enveloping C\*-algebras and GNS. Mathlib has pieces of this; assembling them is a
large project for a corollary.

---

## 3. An elementary proof

The C\*-algebraic content can be replaced by one matrix identity. Notation: `T`
Hermitian Toeplitz, `T_{jk} = c_{j−k}` for `j,k ∈ {0,…,n}`, with
`c_{−l} = conj(c_l)` and `c_0 ∈ ℝ`. Let

- **`T′`** := the leading `n × n` block, `T′_{jk} = c_{j−k}`, `j,k ∈ {0,…,n−1}`;
- **`C`** := the companion matrix of `P/ξ_n`, i.e. the matrix of multiplication
  by `X` on the basis `1, X, …, X^{n−1}`:

      C e_j = e_{j+1}   (j ≤ n−2),        C e_{n−1} = −(1/ξ_n) Σ_{i<n} ξ_i e_i .

### Lemma A (pure algebra — no positivity)

*If `T` is Hermitian Toeplitz, `T ξ = 0`, and `ξ_n ≠ 0`, then*

        Cᴴ T′ C = T′ .

**Proof.** Four cases on `(j,k) ∈ {0,…,n−1}²`.

*`j,k ≤ n−2`.* `(Cᴴ T′ C)_{jk} = T′_{j+1,k+1} = c_{(j+1)−(k+1)} = c_{j−k}`.
This is just Toeplitz shift-invariance.

*`k = n−1`, `j ≤ n−2`.*
`(Cᴴ T′C)_{j,n−1} = Σ_{b<n} c_{(j+1)−b}·(−ξ_b/ξ_n)`. Row `j+1` of `Tξ = 0`
(legitimate since `1 ≤ j+1 ≤ n−1`) gives `Σ_{b≤n} c_{(j+1)−b} ξ_b = 0`, i.e.
`Σ_{b<n} c_{(j+1)−b} ξ_b = −c_{(j+1)−n} ξ_n`. Hence the entry equals
`c_{j−(n−1)} = T′_{j,n−1}`.

*`j = n−1`, `k ≤ n−2`.* Conjugate of the previous case.

*`j = k = n−1`.* The entry is `|ξ_n|^{−2} ⟨ξ′, T′ ξ′⟩` with `ξ′ = (ξ_0,…,ξ_{n−1})`.
Expand `0 = ⟨ξ, Tξ⟩` by splitting off index `n`:

    0 = ⟨ξ′,T′ξ′⟩ + Σ_{a<n} conj(ξ_a) c_{a−n} ξ_n + conj(ξ_n) Σ_{b<n} c_{n−b} ξ_b + |ξ_n|² c_0 .

Row `n` of `Tξ = 0` gives `Σ_{b<n} c_{n−b} ξ_b = −c_0 ξ_n`, so the third term is
`−|ξ_n|² c_0`; the second is its conjugate, also `−|ξ_n|² c_0` (`c_0` real).
Therefore `⟨ξ′,T′ξ′⟩ = |ξ_n|² c_0`, and the entry is `c_0 = T′_{n−1,n−1}`. ∎

*Conceptually:* Lemma A says multiplication by `X` is an isometry for the Gram
form `T′` — the matrix shadow of `X*X = 1`. All of CvS's step 4 is here, and
nothing else is.

### Lemma B (where positivity enters)

*If `T` is PSD with `rank T = n`, and `ξ` spans `ker T`, then `ξ_n ≠ 0` and
`T′ ≻ 0`.*

**Proof.** *`ξ_n ≠ 0`:* suppose `ξ_n = 0` and set `η := (0, ξ_0, …, ξ_{n−1})`.
Toeplitz shift gives `(Tη)_j = (Tξ)_{j−1} = 0` for `j = 1,…,n`. Hence
`⟨η, Tη⟩ = conj(η_0)(Tη)_0 = 0` since `η_0 = 0`. As `T ⪰ 0`, `⟨η,Tη⟩ = 0` forces
`Tη = 0`, so `η ∈ ker T`. If `η = cξ` then `c ≠ 0` (else `ξ = 0`), and
`0 = η_0 = c ξ_0` gives `ξ_0 = 0`, then `η_1 = ξ_0 = 0 = cξ_1` gives `ξ_1 = 0`,
and inductively `ξ = 0` — contradiction. So `dim ker T ≥ 2`, i.e.
`rank T ≤ n−1`, contradicting `rank T = n`.

*`T′ ≻ 0`:* `T′` is PSD as a principal submatrix. If `T′v = 0` with `v ≠ 0`, then
`u := (v,0)` has `⟨u,Tu⟩ = ⟨v,T′v⟩ = 0`, so `Tu = 0` and `u ∈ ker T = span ξ`,
giving `u = cξ` with `c ≠ 0`; but `u_n = 0` forces `ξ_n = 0`, contradiction. ∎

### Lemma C (three lines)

*If `H ≻ 0` and `Cᴴ H C = H`, then every eigenvalue of `C` has modulus 1.*

**Proof.** `Cv = λv`, `v ≠ 0`. Then
`v* H v = v* Cᴴ H C v = |λ|² v* H v`, and `v* H v > 0`, so `|λ|² = 1`. ∎

### Lemma D

Eigenvalues of the companion matrix of `P/ξ_n` are exactly the roots of `P`.
Standard.

### Theorem (= CvS Corollary 1.1)

Lemma B gives `ξ_n ≠ 0` and `T′ ≻ 0`; Lemma A gives `Cᴴ T′ C = T′`; Lemma C
gives `|λ| = 1` for every eigenvalue of `C`; Lemma D identifies those with the
roots of `P`. ∎

---

## 4. Numerical validation

`scripts/cf_check.py` — builds `T = V D V*` on `n` distinct nodes of `𝕋` with
positive weights (the Carathéodory–Fejér normal form, guaranteeing PSD Toeplitz
of rank exactly `n`), extracts `ξ`, and checks every step. For
`n ∈ {3,5,8}` × 2 seeds: Toeplitz error `< 4e−15`, `‖Cᴴ T′ C − T′‖ < 3e−14`,
`max | |root| − 1 | < 1.4e−12`, `λ_min(T′) > 0` throughout, and
`eig(C) = roots(P)` to `< 4e−14`. Also confirms `|ξ_0| = |ξ_n|` in every case —
the self-inversive property CvS derive in Prop 2.1(1).

`scripts/cf_check2.py` — **the discriminating test.** Drops positivity: random
*indefinite* Hermitian Toeplitz matrices with a kernel vector having `ξ_n ≠ 0`.

- `‖Cᴴ T′ C − T′‖ < 9e−15` in **all** trials → **Lemma A genuinely needs no
  positivity**, as the proof says.
- But the conclusion fails: two of nine trials give `max | |root| − 1 |` of
  `5.7e−01` and `2.7e−01`. Roots well off the circle.

So the architecture is confirmed with a counterexample, not just a consistency
check: the identity is free, and **all** the RH-relevant content sits in
Lemma B — in `T′ ≻ 0`, which is exactly positivity. That matches CvS's own remark
that the difficulty becomes verifying that zero is the simple minimal eigenvalue.

---

## 5. What this buys for formalization

The C\*-algebraic route needs Laurent polynomials with involution, localisation,
enveloping C\*-algebras and GNS. The elementary route needs only:

| Ingredient | Mathlib status |
|---|---|
| `Matrix.PosSemidef`, `Matrix.PosDef` | present |
| Hermitian matrices, `conjTranspose` | present |
| companion matrix / `Polynomial.roots` | present |
| principal submatrix (`Matrix.submatrix`) | present |
| rank / kernel dimension | present |
| Toeplitz structure | **not present — define locally** |

Lemma C is immediate. Lemma A is a four-case finite computation. Lemma B is the
one with real content and is still only PSD manipulation. No analysis, no
C\*-algebras, no Carathéodory–Fejér theorem itself.

**Note what is *not* being claimed.** This formalizes Corollary 1.1, the
finite-level statement. CvS's Theorem 1.2 (the distributional analogue, via
Hurwitz on uniform limits of holomorphic functions) is a further and much larger
target, and the `c → ∞` convergence that would give RH is not touched at all.

## 6. Status

Lean development in `CFPositivity/`. See `docs/cf-lean-status.md`.

## Sources

arXiv 2511.23257 (read in full: §1, §2; §3–§7 and appendices skimmed for
structure). Companion notes: `docs/riemann-frontier-trace.md`,
`docs/shi-transfer-problem.md`, `docs/shi-questions.md`.
