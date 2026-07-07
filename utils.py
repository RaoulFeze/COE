import json
import os
from decimal import Decimal, ROUND_HALF_UP, ROUND_DOWN

CONFIG_DIR = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'config')


def load_json(filename):
    path = os.path.join(CONFIG_DIR, filename)
    with open(path) as f:
        return json.load(f)

def testing_capture(self):
    rep = super(SaleOrder, self)
    return res


def round_tax(value):
    d = Decimal(str(value))
    return float(d.quantize(Decimal('0.01'), rounding=ROUND_HALF_UP))


def round_cpp(value):
    d = Decimal(str(value))
    return float(d.quantize(Decimal('0.01'), rounding=ROUND_HALF_UP))


def round_ei(value):
    d = Decimal(str(value))
    return float(d.quantize(Decimal('0.01'), rounding=ROUND_HALF_UP))

