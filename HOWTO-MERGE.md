# Merging upstream

To merge upstream changes I currently do the following
(while manually fixing merge conflicts along the way):

```
	export VERSION=vX.Y.Z
```

1. Merge upstream tag into branch upstream-split and generate project.mml.d
   by running script scripts/split-project.mml.py:
```
	git checkout upstream-split
	git merge $VERSION
	scripts/split-project.mml.py
	git commit --amend
```
   
2. Tag as `vX.Y.Z-split`:

```
	git tag ${VERSION}-split
```

3. Merge `vX.Y.Z-split` into master branch:
```
        git checkout master
        git merge ${VERSION}-l10n0
```

4. If merge has conflicts in project.mml check layer order and call:
```
        scripts/concat-split-project.mml.py >project.mml
        git commit --amend
```


5. Finally tag master branch as `vX.Y.Z-de0`:
```
        git tag ${VERSION}-de0
```

6. Push to GitHUB
```
	git push
        git tag  --list '*l10n*' '*de*' '*split*' |xargs git push origin
```

Sven Geggus 2024-01-20



