#! /bin/bash
#
# decompress-any.bash
# Copyright (C) 2023 fabriceluo <fabriceluo@outlook.com>
#
# Distributed under terms of the MIT license.
#

__ScriptVersion="0.1"

#===  FUNCTION  ================================================================
#         NAME:  usage
#  DESCRIPTION:  Display usage information.
#===============================================================================
function usage ()
{
    echo "Usage :  $0 [options] [--]

    Options:
    -h|help       Display this message
    -v|version    Display script version
    -t|type       The MIME-type of compress type 
    -s|strip-components     skip the components"
}    # ----------  end of function usage  ----------

#-----------------------------------------------------------------------
#  Handle command line arguments
#-----------------------------------------------------------------------
#

strip_components=1

while getopts ":hvs" opt
do
  case $opt in

    h|help)
        usage
        exit 0
        ;;
    v|version)
        echo "$0 -- Version $__ScriptVersion"
        exit 0
        ;;
    s|strip-components)
        strip_components=$OPTARG
        ;;
    * )  echo -e "\n  Option does not exist : $OPTARG\n"
          usage; exit 1   ;;

  esac    # --- end of case ---
done
shift $(($OPTIND-1))

src_file=$1
dst_file=$2

compress_type=$(file -b --mime-type "${src_file}")
if [[ $? -ne 0 ]]; then
    echo "get file(${src_file}) compress type failed"
    exit 1
fi

case $compress_type in
    application/zip)
        unzip "${src_file}" -d "${dst_file}"
        ;;
    application/gzip)
        tar -xf "${src_file}" --strip-components $strip_components -C "${dst_file}"
        ;;
    *)
        echo "unrecognised file(${src_file}) type"
        exit 1
        ;;
esac


