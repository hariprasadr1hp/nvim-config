import re
from errors import PluginError


def get_ex_cmd_str(value: str) -> str:
    """
    a custom pattern to form the `ex-command` string
    """
    # TODO: passing actual-relative-linenumber for the "second-line" argument, maybe "c"
    pattern = (
        r"([ab])([0-9]+)([ab])([0-9]+)([dysj]|[mt]([0\.\$]|[1-9][0-9]*|[ab][0-9]+))"
    )
    regex = re.compile(pattern=pattern)

    try:
        match = regex.search(value)
    except TypeError as e:
        raise PluginError from e

    if not match:
        raise PluginError("Error: no matches found!")

    direction1 = match.group(1)
    line1 = int(match.group(2))
    direction2 = match.group(3)
    line2 = int(match.group(4))
    action = match.group(5)

    fline = -line1 if direction1 == "a" else line1
    lline = fline - line2 if direction2 == "a" else fline + line2

    if fline > lline:
        fline, lline = lline, fline

    if action in "dysj":
        action = "so" if action == "s" else action
    else:
        verb = action[0]
        a = action[1]
        if a in "$.0":
            pass
        elif a in "ab":
            direction3 = "-" if a == "a" else "+"
            action = f"{verb}{direction3}{action[2:]}"
        else:
            pass

    value = "mark z | {}{},{}{}{} | normal! `z".format(
        "+" if fline > 0 else "-",
        abs(fline),
        "+" if lline > 0 else "-",
        abs(lline),
        action,
    )

    return value


def main() -> None:
    maps = {
        "a4b1d": "-4,-3d",
        "b4b1d": "+4,+5d",
        "b4a1d": "+3,+4d",
        "a4a1d": "-5,-4d",
        "a4b5y": "-4,+1y",
        "a4b5s": "-4,+1so",
        "a4b5m.": "-4,+1m.",
        "a4b5m$": "-4,+1m$",
        "a4b5m0": "-4,+1m0",
        "a4b5m10": "-4,+1m10",
        "a4b5ma3": "-4,+1m-3",
    }

    for k, v in maps.items():
        assert get_ex_cmd_str(k) == f"mark z | {v} | normal! `z"


if __name__ == "__main__":
    main()
