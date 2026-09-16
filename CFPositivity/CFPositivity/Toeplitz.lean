import CFPositivity.Isometry
import Mathlib.LinearAlgebra.Matrix.PosDef

/-!
# Connes–van Suijlekom Corollary 1.1, elementary route

`T` Hermitian PSD Toeplitz of size `n+1` and rank `n`, `ξ ∈ ker T`  ⟹  all roots
of `P(z) = Σ ξ_j z^j` lie on the unit circle.  (arXiv:2511.23257, Cor. 1.1.)

The proof replaces CvS's C*-algebraic argument (operator systems, enveloping
C*-algebra, GNS) by one matrix identity:

  * `Lemma A`  `Cᴴ T' C = T'`, where `T'` is the leading `n × n` block and `C`
    is the companion matrix of `P/ξ_n`.  **Pure algebra — no positivity.**
  * `Lemma B`  positivity + rank `n` ⟹ `ξ_n ≠ 0` and `T' ≻ 0`.
  * `Lemma C`  `T' ≻ 0` and `Cᴴ T' C = T'` ⟹ eigenvalues of `C` are unimodular.
    **Proved, sorry-free, in `CFPositivity/Isometry.lean`.**
  * `Lemma D`  eigenvalues of the companion matrix = roots of `P`.

Lemma A is proved via the "embed / shift" decomposition rather than a four-case
entry computation:  writing `E u = (u,0)` and `S u = (0,u)` in `ℂ^{n+1}`,

  * `⟪E u, T E v⟫ = ⟪u, T' v⟫`            (definition)
  * `⟪S u, T S v⟫ = ⟪u, T' v⟫`            (Toeplitz shift invariance)
  * `E (C u) = S u - (u_{n-1}/ξ_n) • ξ`   (definition of `C`)

and `T ξ = 0` kills every cross term.

Numerical validation of all of this: `scripts/cf_check.py`, `scripts/cf_check2.py`.
-/

namespace CFPositivity

open Matrix Finset
open scoped ComplexOrder

variable {n : ℕ}

/-- A Hermitian Toeplitz symbol: `c (-l) = conj (c l)`. -/
structure Symbol where
  c : ℤ → ℂ
  herm : ∀ l : ℤ, c (-l) = star (c l)

namespace Symbol

variable (s : Symbol)

/-- The `(n+1) × (n+1)` Toeplitz matrix of the symbol. -/
def bigMat (n : ℕ) : Matrix (Fin (n + 1)) (Fin (n + 1)) ℂ :=
  Matrix.of fun j k => s.c ((j : ℤ) - (k : ℤ))

/-- The leading `n × n` Toeplitz block. -/
def smallMat (n : ℕ) : Matrix (Fin n) (Fin n) ℂ :=
  Matrix.of fun j k => s.c ((j : ℤ) - (k : ℤ))

lemma bigMat_isHermitian : (s.bigMat n).IsHermitian := by
  ext j k
  simp only [bigMat, Matrix.conjTranspose_apply, Matrix.of_apply]
  rw [← s.herm]
  ring_nf

lemma smallMat_isHermitian : (s.smallMat n).IsHermitian := by
  ext j k
  simp only [smallMat, Matrix.conjTranspose_apply, Matrix.of_apply]
  rw [← s.herm]
  ring_nf

/-- `c 0` is real, since `c (-0) = star (c 0)`. -/
lemma c_zero_conj : (starRingEnd ℂ) (s.c 0) = s.c 0 := by
  have h := s.herm 0
  simpa using h.symm

/-- Shift the symbol's diagonal.  This realises `T - lam • 1` as a Toeplitz
matrix of a symbol, which is what lets the "simple minimal eigenvalue" form
reduce to the positive semidefinite form. -/
def shiftDiag (lam : ℝ) : Symbol where
  c l := if l = 0 then s.c 0 - (lam : ℂ) else s.c l
  herm := by
    intro l
    by_cases h : l = 0
    · subst h
      simp only [neg_zero, star_sub]
      simp [s.c_zero_conj]
    · have h' : -l ≠ 0 := by simpa using h
      simp only [if_neg h, if_neg h']
      exact s.herm l

lemma bigMat_shiftDiag (lam : ℝ) (n : ℕ) :
    (s.shiftDiag lam).bigMat n
      = s.bigMat n - (lam : ℂ) • (1 : Matrix (Fin (n+1)) (Fin (n+1)) ℂ) := by
  ext j k
  by_cases h : j = k
  · subst h
    simp [bigMat, shiftDiag, Matrix.one_apply_eq]
  · have hjk : ((j : ℤ) - (k : ℤ)) ≠ 0 := by
      simp only [sub_ne_zero, ne_eq, Nat.cast_inj]
      exact fun hc => h (Fin.ext (by exact_mod_cast hc))
    simp [bigMat, shiftDiag, Matrix.one_apply_ne h, if_neg hjk]

end Symbol

/-- `ξ` spans the kernel of `M`: it is nonzero, it is killed by `M`, and every
kernel vector is a multiple of it.  For a Hermitian `M` this says the relevant
eigenvalue is **simple**, which is the hypothesis that actually matters (see
`docs/cf-positivity.md` §4) — and unlike `rank M = n` it is what the proofs of
`last_ne_zero` and `smallMat_posDef` really use. -/
def SpansKernel (M : Matrix (Fin (n + 1)) (Fin (n + 1)) ℂ) (ξ : Fin (n + 1) → ℂ) : Prop :=
  ξ ≠ 0 ∧ M *ᵥ ξ = 0 ∧ ∀ v : Fin (n + 1) → ℂ, M *ᵥ v = 0 → ∃ c : ℂ, v = c • ξ

/-! ## The embed and shift maps -/

/-- `E u = (u, 0)` : include `ℂ^n` as the first `n` coordinates of `ℂ^{n+1}`. -/
def embed (u : Fin n → ℂ) : Fin (n + 1) → ℂ :=
  fun j => if h : (j : ℕ) < n then u ⟨j, h⟩ else 0

/-- `S u = (0, u)` : include `ℂ^n` as the last `n` coordinates of `ℂ^{n+1}`. -/
def shift (u : Fin n → ℂ) : Fin (n + 1) → ℂ :=
  fun j => if h : 0 < (j : ℕ) then u ⟨(j : ℕ) - 1, by omega⟩ else 0

@[simp] lemma embed_castSucc (u : Fin n → ℂ) (i : Fin n) :
    embed u i.castSucc = u i := by
  simp [embed, Fin.castSucc, i.isLt]

@[simp] lemma embed_last (u : Fin n → ℂ) : embed u (Fin.last n) = 0 := by
  simp [embed]

/-- The `T`-form restricted along `embed` is the `T'`-form. -/
theorem embed_form (s : Symbol) (u v : Fin n → ℂ) :
    star (embed u) ⬝ᵥ (s.bigMat n) *ᵥ (embed v) = star u ⬝ᵥ (s.smallMat n) *ᵥ v := by
  simp only [dotProduct, mulVec, Symbol.bigMat, Symbol.smallMat, Matrix.of_apply,
    Pi.star_apply]
  rw [Fin.sum_univ_castSucc]
  simp only [embed_last, star_zero, zero_mul, add_zero]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Fin.sum_univ_castSucc]
  simp only [embed_castSucc, embed_last, mul_zero, add_zero, Fin.val_castSucc]

/-- **Toeplitz shift invariance.** The `T`-form restricted along `shift` is also
the `T'`-form.  This is the only place the Toeplitz structure is used. -/
theorem shift_form (s : Symbol) (u v : Fin n → ℂ) :
    star (shift u) ⬝ᵥ (s.bigMat n) *ᵥ (shift v) = star u ⬝ᵥ (s.smallMat n) *ᵥ v := by
  sorry

/-! ## The companion matrix -/

/-- Companion matrix of `P/ξ_n`: multiplication by `X` on the basis
`1, X, …, X^{n-1}` of `ℂ[X]/(P)`. -/
noncomputable def companion (ξ : Fin (n + 1) → ℂ) : Matrix (Fin n) (Fin n) ℂ :=
  Matrix.of fun i j =>
    if (j : ℕ) + 1 < n then (if (i : ℕ) = (j : ℕ) + 1 then 1 else 0)
    else - ξ ⟨i, by omega⟩ / ξ (Fin.last n)

/-- The defining property of the companion matrix:
`E (C u) = S u - (u_{n-1}/ξ_n) • ξ`. -/
theorem embed_companion (ξ : Fin (n + 1) → ℂ) (hn : 0 < n)
    (hξ : ξ (Fin.last n) ≠ 0) (u : Fin n → ℂ) :
    embed (companion ξ *ᵥ u)
      = shift u - (u ⟨n - 1, by omega⟩ / ξ (Fin.last n)) • ξ := by
  sorry

/-! ## Lemma A -/

/-- **Lemma A.**  If `T` is Hermitian Toeplitz and `T ξ = 0` with `ξ_n ≠ 0`, then
the companion matrix is an isometry of the leading block's form.
Positivity is **not** used. -/
theorem companion_isometry (s : Symbol) (ξ : Fin (n + 1) → ℂ) (hn : 0 < n)
    (hξ : ξ (Fin.last n) ≠ 0) (hker : (s.bigMat n) *ᵥ ξ = 0) :
    (companion ξ)ᴴ * (s.smallMat n) * (companion ξ) = s.smallMat n := by
  sorry

/-! ## Lemma B -/

/-- **Lemma B, part 1.**  Positivity and rank `n` force `ξ_n ≠ 0`. -/
theorem last_ne_zero (s : Symbol) (ξ : Fin (n + 1) → ℂ) (hn : 0 < n)
    (hpsd : (s.bigMat n).PosSemidef) (hker : SpansKernel (s.bigMat n) ξ) :
    ξ (Fin.last n) ≠ 0 := by
  sorry

/-- **Lemma B, part 2.**  Then the leading block is positive definite. -/
theorem smallMat_posDef (s : Symbol) (ξ : Fin (n + 1) → ℂ) (hn : 0 < n)
    (hpsd : (s.bigMat n).PosSemidef) (hker : SpansKernel (s.bigMat n) ξ) :
    (s.smallMat n).PosDef := by
  sorry

/-! ## Lemma D -/

/-- **Lemma D.**  A root of `P` is an eigenvalue of the companion matrix. -/
theorem exists_eigenvector_of_root (ξ : Fin (n + 1) → ℂ) (hn : 0 < n)
    (hξ : ξ (Fin.last n) ≠ 0) {z : ℂ}
    (hz : ∑ j : Fin (n + 1), ξ j * z ^ (j : ℕ) = 0) :
    ∃ v : Fin n → ℂ, v ≠ 0 ∧ companion ξ *ᵥ v = z • v := by
  sorry

/-! ## The theorem -/

/-- **Connes–van Suijlekom, Corollary 1.1.**
`T` Hermitian positive semidefinite Toeplitz of size `n+1`, with kernel spanned
by `ξ`.  Then every root of `P(z) = Σ_{j≤n} ξ_j z^j` lies on the unit circle.

The assembly is complete: no `sorry` of its own, discharged against Lemmas A–D. -/
theorem roots_on_circle (s : Symbol) (ξ : Fin (n + 1) → ℂ) (hn : 0 < n)
    (hpsd : (s.bigMat n).PosSemidef) (hker : SpansKernel (s.bigMat n) ξ)
    {z : ℂ} (hz : ∑ j : Fin (n + 1), ξ j * z ^ (j : ℕ) = 0) :
    ‖z‖ = 1 := by
  have hlast : ξ (Fin.last n) ≠ 0 := last_ne_zero s ξ hn hpsd hker
  have hPD : (s.smallMat n).PosDef := smallMat_posDef s ξ hn hpsd hker
  have hiso : (companion ξ)ᴴ * (s.smallMat n) * (companion ξ) = s.smallMat n :=
    companion_isometry s ξ hn hlast hker.2.1
  obtain ⟨v, hv, heig⟩ := exists_eigenvector_of_root ξ hn hlast hz
  exact norm_eq_one_of_posDef_isometry hPD hiso hv heig

/-- **The gap form** — the statement we actually want.

`T` is Hermitian Toeplitz.  `lam` is its **minimal** eigenvalue (`T - lam • 1 ⪰ 0`)
and it is **simple** (the kernel of `T - lam • 1` is spanned by `ξ`).  Then every
root of `P_ξ` lies on the unit circle.

No positivity of `T` and no rank hypothesis.  This subsumes `roots_on_circle`,
which is the case `lam = 0`, and it is the finite analogue of CvS **Theorem 1.2**,
which likewise asks only that the spectral minimum be a simple isolated
eigenvalue — not that it be zero.

Why this form: `lam` enters only through a **spectral gap at the bottom**, which
an interval/enclosure certificate can establish, whereas `rank T = n` is an exact
condition that no margin-robust certificate can see.  See `docs/cf-positivity.md` §4. -/
theorem roots_on_circle_of_simple_min (s : Symbol) (lam : ℝ) (ξ : Fin (n + 1) → ℂ)
    (hn : 0 < n)
    (hmin : (s.bigMat n - (lam : ℂ) • (1 : Matrix (Fin (n+1)) (Fin (n+1)) ℂ)).PosSemidef)
    (hker : SpansKernel (s.bigMat n - (lam : ℂ) • (1 : Matrix (Fin (n+1)) (Fin (n+1)) ℂ)) ξ)
    {z : ℂ} (hz : ∑ j : Fin (n + 1), ξ j * z ^ (j : ℕ) = 0) :
    ‖z‖ = 1 := by
  have hEq := s.bigMat_shiftDiag lam n
  exact roots_on_circle (s.shiftDiag lam) ξ hn (hEq ▸ hmin) (hEq ▸ hker) hz

end CFPositivity
