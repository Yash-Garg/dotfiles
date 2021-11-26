#!C:/KaizokuEncoder/python
import kagefunc as kgf
import lvsfunc as lvf
from vsutil import join, plane

import vapoursynth as vs
core = vs.core
src  = video_in

if src.width < 720:
    deband_args = dict(iterations=2, threshold=3, radius=12)
else:
    deband_args = dict(iterations=2, threshold=4, radius=16)

deband = join([
    core.placebo.Deband(plane(src, 0), grain=4, **deband_args),
    core.placebo.Deband(plane(src, 1), grain=0, **deband_args),
    core.placebo.Deband(plane(src, 2), grain=0, **deband_args)
])

detail_mask = lvf.denoise.detail_mask(src, brz_a=0.045, brz_b=0.06)
merged = core.std.MaskedMerge(deband, src, detail_mask)

grain  = kgf.adaptive_grain(merged, 0.1, luma_scaling=4)

out = grain.std.Crop(240,240,0,0)
out.set_output()
