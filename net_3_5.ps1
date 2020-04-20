# Mount a Win 10 ISO
# Source:D: , where "D" is the drive letter of the mounted ISO; change as necessary

DISM /Online /Enable-Feature /FeatureName:NetFx3 /All /LimitAccess /Source:d:\sources\sxs
