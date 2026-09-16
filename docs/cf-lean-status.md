# Lean formalization status — CvS Corollary 1.1

Project: `CFPositivity/` · Lean **4.34.0** · Mathlib pinned by
`CFPositivity/lake-manifest.json` · builds clean (`lake build`, 2195 jobs).

Math: `docs/cf-positivity.md`. Numerics: `scripts/cf_check.py`,
`scripts/cf_check2.py`.

`.lake/` is gitignored — reproduce with `lake exe cache get` (~8 GB).

---

## What is proved

| Result | File | Status |
|---|---|---|
| `dotProduct_mulVec_of_isometry` | `Isometry.lean` | **proved** |
| **`norm_eq_one_of_posDef_isometry`** (Lemma C) | `Isometry.lean` | **proved, sorry-free** |
| `Symbol.bigMat_isHermitian`, `smallMat_isHermitian` | `Toeplitz.lean` | **proved** |
| `Symbol.c_zero_conj` (`c₀` is real) | `Toeplitz.lean` | **proved** |
| `Symbol.shiftDiag` + **`Symbol.bigMat_shiftDiag`** | `Toeplitz.lean` | **proved, sorry-free** — the `T ↦ T − λ·1` reduction |
| `embed_castSucc`, `embed_last`, `embed_form` | `Toeplitz.lean` | **proved** |
| `roots_on_circle` (PSD form) | `Toeplitz.lean` | assembly complete, no `sorry` of its own |
| **`roots_on_circle_of_simple_min`** (gap form) | `Toeplitz.lean` | assembly complete, no `sorry` of its own |

Axiom check:

```
roots_on_circle_of_simple_min  →  [propext, sorryAx, Classical.choice, Quot.sound]
Symbol.bigMat_shiftDiag        →  [propext, Classical.choice, Quot.sound]
norm_eq_one_of_posDef_isometry →  [propext, Classical.choice, Quot.sound]
```

`sorryAx` on the top theorem is inherited from the six open lemmas below; its own
proof is clean. The reduction and Lemma C stand on standard axioms alone.

## The two statements

**Gap form — the real target.** No positivity of `T`, no rank hypothesis:

```lean
theorem roots_on_circle_of_simple_min (s : Symbol) (lam : ℝ) (ξ : Fin (n+1) → ℂ)
    (hn : 0 < n)
    (hmin : (s.bigMat n - (lam : ℂ) • 1).PosSemidef)
    (hker : SpansKernel (s.bigMat n - (lam : ℂ) • 1) ξ)
    {z : ℂ} (hz : ∑ j : Fin (n + 1), ξ j * z ^ (j : ℕ) = 0) :
    ‖z‖ = 1
```

`hmin` says `lam` is at or below the bottom of the spectrum; `hker` says the
`lam`-eigenspace is spanned by `ξ`, i.e. `lam` is the minimum **and simple**.
Together: a **spectral gap at the bottom**. Proved by applying the PSD form to
`s.shiftDiag lam`, via `bigMat_shiftDiag`.

**PSD form** (`roots_on_circle`) is the special case `lam = 0`, kept because the
six lemmas are stated against it.

### `SpansKernel` replaced `rank = n`

```lean
def SpansKernel (M : Matrix (Fin (n+1)) (Fin (n+1)) ℂ) (ξ : Fin (n+1) → ℂ) : Prop :=
  ξ ≠ 0 ∧ M *ᵥ ξ = 0 ∧ ∀ v, M *ᵥ v = 0 → ∃ c : ℂ, v = c • ξ
```

Equivalent to `rank M = n` here, but strictly better to work with: it is what the
proofs of `last_ne_zero` and `smallMat_posDef` actually use (both argue by
producing a second, independent kernel vector), so those arguments now go through
directly instead of via rank arithmetic. It also drops the
`Mathlib.LinearAlgebra.Matrix.Rank` dependency.

## What remains (6 `sorry`s)

| Lemma | Content | Difficulty |
|---|---|---|
| `shift_form` | Toeplitz shift invariance `⟪S u, T S v⟫ = ⟪u, T' v⟫`. The **only** place the Toeplitz structure is used. | Low — same shape as the proved `embed_form`; index bookkeeping is `(j+1)−(k+1) = j−k`. |
| `embed_companion` | `E (C u) = S u − (u_{n−1}/ξ_n) • ξ`. | Low–medium. Pure `Fin` index work. |
| `companion_isometry` | **Lemma A**: `Cᴴ T' C = T'`. | Medium but *short* once the two above land. |
| `last_ne_zero` | **Lemma B1**: `ξ_n ≠ 0`. | Medium. Needs `⟪x,Tx⟫ = 0 → Tx = 0` for PSD, then the shifted-vector independence argument against `SpansKernel`. |
| `smallMat_posDef` | **Lemma B2**: `T' ≻ 0`. | Low given B1. |
| `exists_eigenvector_of_root` | **Lemma D**: root of `P` ⟹ eigenvector of the companion matrix. | Low–medium; classical. |

None needs analysis, C\*-algebras, or Carathéodory–Fejér itself.

## Design notes

- **Toeplitz is not in Mathlib.** Defined locally as a `Symbol` structure
  (`c : ℤ → ℂ` with `c (-l) = star (c l)`), with `bigMat`/`smallMat` derived.
  Worth extracting if this grows.
- **The embed/shift route.** Lemma A is set up through
  `embed u = (u,0)` and `shift u = (0,u)` in `ℂ^{n+1}` rather than as a
  four-case entry computation. Both give the same theorem; the four-case version
  is written out in `docs/cf-positivity.md` §3 and was the one checked
  numerically. The embed/shift version localises the Toeplitz structure into a
  single lemma (`shift_form`), which is why it was chosen here.
- `companion` is `noncomputable` (division in `ℂ`).
- `Matrix.PosDef` in this Mathlib is stated over a `StarRing` + `PartialOrder`,
  so `PosDef.dotProduct_mulVec_pos` gives `0 < star x ⬝ᵥ M *ᵥ x` **in `ℂ`**
  directly, under `open scoped ComplexOrder`. No `RCLike.re` detour needed.

## Scope

This formalizes **Corollary 1.1 only** — the finite-level statement. Not in
scope, and much larger:

- CvS **Theorem 1.2**, the distributional analogue (needs Hurwitz on uniform
  limits of holomorphic functions, plus §3–§5 of the paper);
- the Carathéodory–Fejér theorem itself (`T = V D V*` on the circle);
- the `c → ∞` convergence that would give RH — untouched, and per
  `docs/riemann-frontier-trace.md` §3.4 that is where the entire difficulty sits.

CvS themselves state where the difficulty moves: *"The key difficulty in this
context, then, becomes the verification that zero is indeed the (simple) minimal
eigenvalue of `T`."* Nothing here addresses that.

Also note CvS Remark 2.3: **simplicity of the minimal eigenvalue is essential.**
If `dim ker T > 1` the statement is false as given; the correct version concerns
the intersection of the zero sets of the eigenfunctions. Our `hrank = n`
hypothesis encodes simplicity and must not be weakened.
