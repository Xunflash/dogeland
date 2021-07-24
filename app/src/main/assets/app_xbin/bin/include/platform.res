platform_check()
{
    local arch="$1"
   # arch=$(uname -m)
    arch=$(getprop ro.product.cpu.abi)
    case "${arch}" in
    arm64-v8a|aarch64|armv8l)
        echo "arm64"
    ;;
    armeabi-v7a|armeabi|arm*)
        echo "arm"
    ;;
    x86_64|amd64)
        echo "x86_64"
    ;;
    *)
        echo "unknown"
    ;;
    esac
}