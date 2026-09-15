import CFPositivity.Isometry
import Mathlib.LinearAlgebra.Matrix.PosDef
import Mathlib.LinearAlgebra.Matrix.Rank

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

end Symbol

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
    (hpsd : (s.bigMat n).PosSemidef) (hrank : (s.bigMat n).rank = n)
    (hker : (s.bigMat n) *ᵥ ξ = 0) (hξ0 : ξ ≠ 0) :
    ξ (Fin.last n) ≠ 0 := by
  sorry

/-- **Lemma B, part 2.**  Then the leading block is positive definite. -/
theorem smallMat_posDef (s : Symbol) (ξ : Fin (n + 1) → ℂ) (hn : 0 < n)
    (hpsd : (s.bigMat n).PosSemidef) (hrank : (s.bigMat n).rank = n)
    (hker : (s.bigMat n) *ᵥ ξ = 0) (hξ0 : ξ ≠ 0) :
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
Let `T` be a Hermitian positive semidefinite Toeplitz matrix of size `n+1` and
rank `n`, and let `ξ` span its kernel.  Then every root of
`P(z) = Σ_{j≤n} ξ_j z^j` lies on the unit circle.

The assembly below is complete; it depends only on Lemmas A, B, C, D. -/
theorem roots_on_circle (s : Symbol) (ξ : Fin (n + 1) → ℂ) (hn : 0 < n)
    (hpsd : (s.bigMat n).PosSemidef) (hrank : (s.bigMat n).rank = n)
    (hker : (s.bigMat n) *ᵥ ξ = 0) (hξ0 : ξ ≠ 0)
    {z : ℂ} (hz : ∑ j : Fin (n + 1), ξ j * z ^ (j : ℕ) = 0) :
    ‖z‖ = 1 := by
  have hlast : ξ (Fin.last n) ≠ 0 := last_ne_zero s ξ hn hpsd hrank hker hξ0
  have hPD : (s.smallMat n).PosDef := smallMat_posDef s ξ hn hpsd hrank hker hξ0
  have hiso : (companion ξ)ᴴ * (s.smallMat n) * (companion ξ) = s.smallMat n :=
    companion_isometry s ξ hn hlast hker
  obtain ⟨v, hv, heig⟩ := exists_eigenvector_of_root ξ hn hlast hz
  exact norm_eq_one_of_posDef_isometry hPD hiso hv heig

end CFPositivity
