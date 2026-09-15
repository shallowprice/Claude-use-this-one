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
| `Symbol.bigMat_isHermitian` | `Toeplitz.lean` | **proved** |
| `Symbol.smallMat_isHermitian` | `Toeplitz.lean` | **proved** |
| `embed_castSucc`, `embed_last` | `Toeplitz.lean` | **proved** |
| `embed_form` | `Toeplitz.lean` | **proved** |
| **`roots_on_circle`** (the theorem) | `Toeplitz.lean` | **assembly complete** — no `sorry` of its own; discharges entirely against the six lemmas below |

`#print axioms CFPositivity.norm_eq_one_of_posDef_isometry` →
`[propext, Classical.choice, Quot.sound]`. Standard only.

**Lemma C is the mathematically load-bearing step** — it is where positivity
becomes "zeros on the circle":

```lean
theorem norm_eq_one_of_posDef_isometry
    {H C : Matrix m m ℂ} (hH : H.PosDef) (hiso : Cᴴ * H * C = H)
    {lam : ℂ} {v : m → ℂ} (hv : v ≠ 0) (heig : C *ᵥ v = lam • v) :
    ‖lam‖ = 1
```

## What remains (6 `sorry`s)

| Lemma | Content | Difficulty |
|---|---|---|
| `shift_form` | Toeplitz shift invariance: `⟪S u, T S v⟫ = ⟪u, T' v⟫`. The **only** place the Toeplitz structure is used. | Low — same shape as the proved `embed_form`, but the index bookkeeping is `(j+1)-(k+1) = j-k` rather than a restriction. |
| `embed_companion` | `E (C u) = S u - (u_{n-1}/ξ_n) • ξ` — the defining property of the companion matrix. | Low–medium. Pure `Fin` index work. |
| `companion_isometry` | **Lemma A**: `Cᴴ T' C = T'`. | Medium, but *short* once the two above land: expand via `embed_companion`, apply `shift_form`, and kill three cross terms with `T ξ = 0` + Hermitian. |
| `last_ne_zero` | **Lemma B1**: `ξ_n ≠ 0`. | Medium. Needs the PSD fact `⟪x,Tx⟫ = 0 → Tx = 0`, plus the shifted-vector independence argument. |
| `smallMat_posDef` | **Lemma B2**: `T' ≻ 0`. | Low given B1. |
| `exists_eigenvector_of_root` | **Lemma D**: root of `P` ⟹ eigenvector of companion matrix. | Low–medium; classical, may partly exist in Mathlib via `Matrix.charpoly` of the companion matrix. |

None requires analysis, C\*-algebras, or the Carathéodory–Fejér theorem itself.
All six are finite linear algebra.

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
