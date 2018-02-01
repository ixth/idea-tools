#!/usr/bin/env bash

ssh dev docker exec -t hhmobile "easy_install pydevd"

git apply <<DOC
--- a/hhmobile/__init__.py
+++ b/hhmobile/__init__.py
@@ -10,6 +10,9 @@ from hhmobile import config
 from hhmobile.page import MobileNotFoundHandler
 from hhmobile.postprocessor.template import get_jinja_environment

+import pydevd
+pydevd.settrace('127.0.0.1', port=32222, stdoutToServer=True, stderrToServer=True, suspend=False)
+

 class HHMobileApplication(FrontikApplication):
     def __init__(self, **settings):
DOC

ssh dev docker restart hhmobile
