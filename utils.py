import json
import os
from decimal import Decimal, ROUND_HALF_UP, ROUND_DOWN

CONFIG_DIR = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'config')


def load_json(filename):
    path = os.path.join(CONFIG_DIR, filename)
    with open(path) as f:
        return json.load(f)


def round_tax(value):
    d = Decimal(str(value))
    return float(d.quantize(Decimal('0.01'), rounding=ROUND_HALF_UP))


def round_cpp(value):
    d = Decimal(str(value))
    return float(d.quantize(Decimal('0.01'), rounding=ROUND_HALF_UP))


def round_ei(value):
    d = Decimal(str(value))
    return float(d.quantize(Decimal('0.01'), rounding=ROUND_HALF_UP))


def truncate_cpp_exemption(value):
    d = Decimal(str(value))
    return float(d.quantize(Decimal('0.01'), rounding=ROUND_DOWN))


PAY_PERIOD_MAP = {
    'weekly': 52,
    'biweekly': 26,
    'semi_monthly': 24,
    'monthly': 12,
}
