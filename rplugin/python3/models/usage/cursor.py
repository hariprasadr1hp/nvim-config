import datetime
from pydantic import BaseModel, ConfigDict
from pydantic.alias_generators import to_camel


class CamelCaseModel(BaseModel):
    model_config = ConfigDict(extra="ignore", alias_generator=to_camel)


class Plan(CamelCaseModel):
    enabled: bool
    used: int
    limit: int
    remaining: int
    auto_spend: int
    api_spend: int
    auto_limit: int
    api_limit: int


class OnDemand(CamelCaseModel):
    enabled: bool = False
    used: int = 0
    limit: int | None = None
    remaining: int | None = None


class IndividualUsage(CamelCaseModel):
    plan: Plan
    on_demand: OnDemand


class CursorUsage(CamelCaseModel):
    billing_cycle_start: datetime.datetime
    billing_cycle_end: datetime.datetime
    membership_type: str
    limit_type: str
    is_unlimited: bool
    individual_usage: IndividualUsage
    team_usage: dict


def main() -> None:
    import json

    with open("tests/data/usage/cursor.json") as rf:
        data = json.load(rf)
    CursorUsage(**data)


if __name__ == "__main__":
    main()
