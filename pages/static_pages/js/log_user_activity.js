/*..*/
function log_user_activity(event) {
    var currentTargetAttributes = event.currentTarget.attributes;
    for (var i = 0; i < currentTargetAttributes.length; i++) {
        if (currentTargetAttributes[i].name == "log-id") {
            add_user_activity_log(currentTargetAttributes[i].value, event.type)
        }
    }
}

function add_user_activity_log(log_id, event_type) {
    var token = "";
    try
    {
        token = user_token;
    }
    catch(ex){

    }
    var url = "/api/log_user_activity.aspx?logid=" + log_id + "&type=" + event_type + "&usertoken=" + token + "&timestamp=" + (new Date()).valueOf();
    $.ajax({
        type: "get",
        url: url
        
    });
}