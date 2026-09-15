import Mathlib.LinearAlgebra.Matrix.PosDef
import Mathlib.Analysis.Complex.Basic
import Mathlib.Analysis.Complex.Order

/-!
# Lemma C: an isometry of a positive definite form has unimodular eigenvalues

This is the step that turns *positivity* into *zeros on the circle* in
Connes–van Suijlekom, Corollary 1.1 (arXiv:2511.23257).

See `docs/cf-positivity.md` for the surrounding argument.
-/

namespace CFPositivity

open Matrix
open scoped ComplexOrder

variable {m : Type*} [Fintype m]

/-- If `C` preserves the sesquilinear form given by `H` (i.e. `Cᴴ * H * C = H`),
then the `H`-quadratic value is unchanged along `C`. -/
theorem dotProduct_mulVec_of_isometry
    {H C : Matrix m m ℂ} (hiso : Cᴴ * H * C = H) (v : m → ℂ) :
    star (C *ᵥ v) ⬝ᵥ H *ᵥ (C *ᵥ v) = star v ⬝ᵥ H *ᵥ v := by
  rw [star_mulVec, ← dotProduct_mulVec, mulVec_mulVec, mulVec_mulVec, hiso]

/-- **Lemma C.** If `H` is positive definite and `Cᴴ * H * C = H`, then every
eigenvalue of `C` has modulus one. -/
theorem norm_eq_one_of_posDef_isometry
    {H C : Matrix m m ℂ} (hH : H.PosDef) (hiso : Cᴴ * H * C = H)
    {lam : ℂ} {v : m → ℂ} (hv : v ≠ 0) (heig : C *ᵥ v = lam • v) :
    ‖lam‖ = 1 := by
  have hq : 0 < star v ⬝ᵥ H *ᵥ v := hH.dotProduct_mulVec_pos hv
  have hq0 : star v ⬝ᵥ H *ᵥ v ≠ 0 := ne_of_gt hq
  have key := dotProduct_mulVec_of_isometry hiso v
  rw [heig] at key
  have hexp : star (lam • v) ⬝ᵥ H *ᵥ (lam • v)
      = (starRingEnd ℂ lam * lam) * (star v ⬝ᵥ H *ᵥ v) := by
    rw [mulVec_smul, star_smul, smul_dotProduct, dotProduct_smul]
    simp [mul_assoc, smul_eq_mul]
  rw [hexp] at key
  -- `key : (conj lam * lam) * q = q` with `q ≠ 0`
  have h2 : (starRingEnd ℂ lam * lam - 1) * (star v ⬝ᵥ H *ᵥ v) = 0 := by
    rw [sub_mul, one_mul, key, sub_self]
  have h1 : starRingEnd ℂ lam * lam = 1 := by
    rcases mul_eq_zero.mp h2 with h | h
    · exact sub_eq_zero.mp h
    · exact absurd h hq0
  have h3 : ‖starRingEnd ℂ lam * lam‖ = 1 := by rw [h1]; simp
  rw [norm_mul] at h3
  have h4 : ‖starRingEnd ℂ lam‖ = ‖lam‖ := by simp
  rw [h4] at h3
  nlinarith [norm_nonneg lam]

end CFPositivity
