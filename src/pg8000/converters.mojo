from collections import Dict, List
from python import Python
from sys import info
from decimojo import Decimal


# Import Python modules that don't have Mojo equivalents yet
let datetime = Python.import_module("datetime")

let ipaddress = Python.import_module("ipaddress")
let json = Python.import_module("json")
let uuid = Python.import_module("uuid")
let dateutil_parser = Python.import_module("dateutil.parser")

# These would need to be implemented or imported from your pg8000 equivalent
# from src.pg8000.exceptions import InterfaceError
# from src.pg8000.types import PGInterval, Range

# PostgreSQL type constants - using alias for better Mojo style
alias ANY_ARRAY: Int32 = 2277
alias BIGINT: Int32 = 20
alias BIGINT_ARRAY: Int32 = 1016
alias BOOLEAN: Int32 = 16
alias BOOLEAN_ARRAY: Int32 = 1000
alias BYTES: Int32 = 17
alias BYTES_ARRAY: Int32 = 1001
alias CHAR: Int32 = 1042
alias CHAR_ARRAY: Int32 = 1014
alias CIDR: Int32 = 650
alias CIDR_ARRAY: Int32 = 651
alias CSTRING: Int32 = 2275
alias CSTRING_ARRAY: Int32 = 1263
alias DATE: Int32 = 1082
alias DATE_ARRAY: Int32 = 1182
alias DATEMULTIRANGE: Int32 = 4535
alias DATEMULTIRANGE_ARRAY: Int32 = 6155
alias DATERANGE: Int32 = 3912
alias DATERANGE_ARRAY: Int32 = 3913
alias FLOAT: Int32 = 701
alias FLOAT_ARRAY: Int32 = 1022
alias INET: Int32 = 869
alias INET_ARRAY: Int32 = 1041
alias INT2VECTOR: Int32 = 22
alias INT4MULTIRANGE: Int32 = 4451
alias INT4MULTIRANGE_ARRAY: Int32 = 6150
alias INT4RANGE: Int32 = 3904
alias INT4RANGE_ARRAY: Int32 = 3905
alias INT8MULTIRANGE: Int32 = 4536
alias INT8MULTIRANGE_ARRAY: Int32 = 6157
alias INT8RANGE: Int32 = 3926
alias INT8RANGE_ARRAY: Int32 = 3927
alias INTEGER: Int32 = 23
alias INTEGER_ARRAY: Int32 = 1007
alias INTERVAL: Int32 = 1186
alias INTERVAL_ARRAY: Int32 = 1187
alias OID: Int32 = 26
alias JSON: Int32 = 114
alias JSON_ARRAY: Int32 = 199
alias JSONB: Int32 = 3802
alias JSONB_ARRAY: Int32 = 3807
alias MACADDR: Int32 = 829
alias MONEY: Int32 = 790
alias MONEY_ARRAY: Int32 = 791
alias NAME: Int32 = 19
alias NAME_ARRAY: Int32 = 1003
alias NUMERIC: Int32 = 1700
alias NUMERIC_ARRAY: Int32 = 1231
alias NUMRANGE: Int32 = 3906
alias NUMRANGE_ARRAY: Int32 = 3907
alias NUMMULTIRANGE: Int32 = 4532
alias NUMMULTIRANGE_ARRAY: Int32 = 6151
alias NULLTYPE: Int32 = -1
alias POINT: Int32 = 600
alias REAL: Int32 = 700
alias REAL_ARRAY: Int32 = 1021
alias RECORD: Int32 = 2249
alias SMALLINT: Int32 = 21
alias SMALLINT_ARRAY: Int32 = 1005
alias SMALLINT_VECTOR: Int32 = 22
alias STRING: Int32 = 1043
alias TEXT: Int32 = 25
alias TEXT_ARRAY: Int32 = 1009
alias TIME: Int32 = 1083
alias TIME_ARRAY: Int32 = 1183
alias TIMESTAMP: Int32 = 1114
alias TIMESTAMP_ARRAY: Int32 = 1115
alias TIMESTAMPTZ: Int32 = 1184
alias TIMESTAMPTZ_ARRAY: Int32 = 1185
alias TSMULTIRANGE: Int32 = 4533
alias TSMULTIRANGE_ARRAY: Int32 = 6152
alias TSRANGE: Int32 = 3908
alias TSRANGE_ARRAY: Int32 = 3909
alias TSTZMULTIRANGE: Int32 = 4534
alias TSTZMULTIRANGE_ARRAY: Int32 = 6153
alias TSTZRANGE: Int32 = 3910
alias TSTZRANGE_ARRAY: Int32 = 3911
alias UNKNOWN: Int32 = 705
alias UUID_TYPE: Int32 = 2950
alias UUID_ARRAY: Int32 = 2951
alias VARCHAR: Int32 = 1043
alias VARCHAR_ARRAY: Int32 = 1015
alias XID: Int32 = 28

# Integer bounds - using compile-time constants
alias MIN_INT2: Int64 = -(2**15)
alias MAX_INT2: Int64 = 2**15
alias MIN_INT4: Int64 = -(2**31)
alias MAX_INT4: Int64 = 2**31
alias MIN_INT8: Int64 = -(2**63)
alias MAX_INT8: Int64 = 2**63

# Function converted to Mojo style
fn bool_in(data: String) -> Bool:
    """Convert PostgreSQL boolean string to Mojo Bool."""
    return data == "t"

# Alternative version with error handling
fn bool_in_safe(data: String) raises -> Bool:
    """Convert PostgreSQL boolean string to Mojo Bool with validation."""
    if data == "t":
        return True
    elif data == "f":
        return False
    else:
        raise Error("Invalid boolean value: expected 't' or 'f', got '" + data + "'")

# If you want to create a struct-based approach for better performance:
@value
struct PGTypes:
    """PostgreSQL type constants as a struct for better organization."""

    # Core types
    var any_array: Int32
    var bigint: Int32
    var boolean: Int32
    var text: Int32

    fn __init__(inout self):
        self.any_array = ANY_ARRAY
        self.bigint = BIGINT
        self.boolean = BOOLEAN
        self.text = TEXT

    fn is_array_type(self, type_oid: Int32) -> Bool:
        """Check if the given OID represents an array type."""
        # Array types typically have OIDs > 1000 (this is a simplified check)
        return type_oid > 1000 and type_oid != RECORD

# Example usage function
fn example_usage():
    """Demonstrate usage of the converted types."""
    let pg_types = PGTypes()

    # Test boolean conversion
    let bool_result = bool_in("t")
    print("Boolean result:", bool_result)

    # Test bounds
    print("INT2 range:", MIN_INT2, "to", MAX_INT2)
    print("INT4 range:", MIN_INT4, "to", MAX_INT4)
    print("INT8 range:", MIN_INT8, "to", MAX_INT8)

    # Test type checking
    print("Is BIGINT_ARRAY an array type?", pg_types.is_array_type(BIGINT_ARRAY))