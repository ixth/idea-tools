#!/usr/bin/env bash

ssh dev docker exec -t frontik "easy_install pydevd"

git apply <<DOC
--- a/xhh/__init__.py
+++ b/xhh/__init__.py
@@ -17,6 +17,9 @@ from xhh.version import version
 from xhh import config
 from xhh.pages import not_found

+import pydevd
+pydevd.settrace('127.0.0.1', port=32223, stdoutToServer=True, stderrToServer=True, suspend=False)
+
 UNKNOWN_EXTENSIONS = ('.png', '.gif', '.jpg', '.jpeg', '.js', '.css', '.php')


DOC

ssh dev docker restart frontik
