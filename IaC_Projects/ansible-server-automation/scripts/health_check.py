#!/usr/bin/env python3
"""Check the HTTP status of one or more servers and report the results.

Usage:
    python3 health_check.py http://1.2.3.4 http://example.com
Exit code is 0 if every server is healthy, 1 if any check fails.
"""
import json
import sys
import time
import urllib.error
import urllib.request
from datetime import datetime, timezone


def check(url: str, timeout: int = 5) -> dict:
    start = time.time()
    result = {"url": url, "checked_at": datetime.now(timezone.utc).isoformat()}
    try:
        with urllib.request.urlopen(url, timeout=timeout) as resp:
            result["status_code"] = resp.status
            result["healthy"] = 200 <= resp.status < 400
    except urllib.error.HTTPError as err:
        result["status_code"] = err.code
        result["healthy"] = False
    except (urllib.error.URLError, TimeoutError) as err:
        result["status_code"] = None
        result["healthy"] = False
        result["error"] = str(err)
    result["response_time_ms"] = round((time.time() - start) * 1000, 1)
    return result


def main(urls: list) -> int:
    if not urls:
        print(__doc__)
        return 2
    results = [check(u) for u in urls]
    for r in results:
        state = "OK  " if r["healthy"] else "FAIL"
        print(f"[{state}] {r['url']} status={r['status_code']} time={r['response_time_ms']}ms")
    with open("health_report.json", "w") as f:
        json.dump(results, f, indent=2)
    return 0 if all(r["healthy"] for r in results) else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
