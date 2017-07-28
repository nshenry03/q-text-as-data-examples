#!/bin/bash
#===============================================================================
#
#          FILE:  count_versions.sh
# 
#         USAGE:  ./count_versions.sh 
# 
#   DESCRIPTION:  Displays a count of the number of versions for each
#                 application.
# 
#        AUTHOR:  Nick Henry (NSH), nicholas.henry@appdirect.com
#       COMPANY:  AppDirect
#       VERSION:  1.0
#       CREATED:  07/28/2017 02:18:35 AM MDT
#===============================================================================

set -o nounset                                  # treat unset variables as errors

#===============================================================================
#   GLOBAL DECLARATIONS
#===============================================================================
declare -rx DATA_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../data"


#===============================================================================
#   PASSED VARIABLES
#===============================================================================
USAGE="

USAGE:

  Arguments:
    -c|--count:     Display only apps that have greater than or equal to this
                    many versions (Default is 0)

    -h|--help:      Display usage information
  ----------------------------------------------------------

  Examples:
    ${0} --count=5

"

# :WARNING: The quotes around `$@' are essential!
TEMP=`getopt -q -o c:h --long \
  count:,help\
  -n "${0}" -- "${@}"`

# :WARNING: The quotes around `$TEMP' are essential!
eval set -- "$TEMP"

while true ; do
  case "$1" in
    -c|--count)    COUNT="${2}" ; shift 2 ;;
    -h|--help)  echo "${USAGE}" ;  exit 0 ;;
    --)                   shift ; break   ;;
  esac
done

COUNT="${COUNT:-0}"                             # Set default count to 0

#===============================================================================
#   MAIN SCRIPT
#===============================================================================

# Print Header
echo "application,count"

# Run Report
xargs -0 <<-EOF /usr/bin/q --skip-header --delimiter=','
  SELECT
    a.title,
    COUNT(av.id)
  FROM
    ${DATA_DIR}/Application.csv a JOIN ${DATA_DIR}/ApplicationVersion.csv av
      ON (av.application_id = a.id)
  GROUP BY a.id
  HAVING COUNT(av.id) >= ${COUNT}
  ORDER BY
    COUNT(av.id) DESC,
    a.title
EOF


#===============================================================================
#   STATISTICS / CLEANUP
#===============================================================================
exit 0
