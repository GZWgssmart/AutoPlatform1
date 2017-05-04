var contentPath='';

function userLogin() {
    $.post(contentPath+"/user/login",$("#loginForm").serialize(),function (data) {
        if(data.result=="success"){
            alert("登陆成功");
        }else{
            alert("登陆失败");
        }
    })
}
