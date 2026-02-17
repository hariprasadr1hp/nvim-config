import datetime
from pydantic import BaseModel, ConfigDict


class Usage(BaseModel):
    utilization: float
    resets_at: datetime.datetime | None


class ClaudeUsage(BaseModel):
    model_config = ConfigDict(extra="ignore")
    five_hour: Usage
    seven_day: Usage


def main() -> None:
    import json

    with open("./tests/data/usage/claude.json", mode="r") as rf:
        data = json.load(rf)
    ClaudeUsage(**data)


if __name__ == "__main__":
    main()
