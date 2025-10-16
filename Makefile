
PY_NAMES := genconfig.py menuconfig.py olddefconfig.py
PY_FILES_SRC := $(foreach f,$(PY_NAMES),work/kconfiglib/$(f))
PY_FILES := $(foreach f,$(PY_NAMES),src/kconfiglib/$(f)) 

all: py

py: $(PY_FILES) src/LICENSE.txt pyproject.toml src/kconfiglib/__init__.py
	pyproject-build

get-upstream: $(PY_FILES_SRC)

src/kconfiglib:
	mkdir $@

$(PY_FILES) &: $(PY_FILES_SRC) src/kconfiglib
	cp -v $(PY_FILES_SRC) src/kconfiglib

$(PY_FILES_SRC) work/kconfiglib/kconfiglib.py work/kconfiglib/LICENSE.txt:
	scripts/get-upstream

src/kconfiglib/__init__.py: work/kconfiglib/kconfiglib.py
	cp -v "$<" "$@"

src/LICENSE.txt: work/kconfiglib/LICENSE.txt
	cp -v "$<" "$@"

work/klipper_version: get-upstream 
	GIT_DIR=work/klipper_git/.git git describe --always --long --tags > "$@"

clean:
	rm -rf work/klipper_git work/klipper_version build dist $(PY_FILES_DST)

.PHONY: get-upstream py all clean
