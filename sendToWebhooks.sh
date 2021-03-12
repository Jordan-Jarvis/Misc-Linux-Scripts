function send_to_webhooks(){
    #vars: summary, message, extra_flags, extra_Hooks (ARRAY)
    local summary=${1:-"Error! No summary provided!"} #JSON summary
    local message=${2:-"Error! No message provided!"} #JSON message
    local extra_flags=${3:-""} # content type and extra switches. Default set to JSON
    local extra_Hooks=${4:-1} # Allows for specific webhooks to be added by function parameter as an array.
    
    message="\"$message\"" # add quotes automatically
    summary="\"$summary\""
    
    
    #Always defined webhooks
    default_Hooks=()
    default_Hooks+=('https://yourwebhook here') # convert to list if not already one
    default_Hooks+=('https://your2ndwebhook here')

    default_Hooks+=("${extra_Hooks[@]}")
    for URL in "${default_Hooks[@]}"
    do
        curl -s -X POST --url $URL -d "{\"Summary\": $summary,\"Message\": $message }" -H 'Content-Type: application/json' $extra_flags
    done
    # send it to traditional channels as well
    curl -s -X POST -d "{\"text\": "$message"}" "$extra_flags"
}


#example use:

# summary="I am goo."
# message="The acid got to me, I am now a gooey mess"
# extra_flags=" " # add any extra flags or pipes with more commands on to the end of the curl command
# extra_Hooks=('https://thirdwebhook') # Add more webhook urls via function parameters

# send_to_webhooks "$summary" "$message" "$extra_flags" $extra_Hooks