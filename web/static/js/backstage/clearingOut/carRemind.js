$(function () {
    $("#addSelect").select2({
        language: 'zh-CN'
    });
});

function showBell(){
    var row =  $('table').bootstrapTable('getSelections');
    if(row.length >0) {
        swal({
            title:"",
            text: "提醒成功",
            confirmButtonText:"确定",
            type:"success"})
    }else{
        swal({
            title:"",
            text: "请先选择要提醒的车主", // 主要文本
            confirmButtonColor: "#DD6B55", // 提示按钮的颜色
            confirmButtonText:"确定", // 提示按钮上的文本
            type:"warning"}) // 提示类型
    }
}

function showBellAll(){
    // 这里应该要判断是否当前表格是否有已经完成维修保养的车, 表格无数据时 应提醒当前暂无需要提醒的车
    swal(
        {title:"",
            text:"您确定要提醒全部吗",
            type:"warning",
            showCancelButton:true,
            confirmButtonColor:"#DD6B55",
            confirmButtonText:"我确定",
            cancelButtonText:"再考虑一下",
            closeOnConfirm:false,
            closeOnCancel:false
        },function(isConfirm){
            if(isConfirm)
            {
                swal({title:"",
                    text:"全部提醒成功",
                    type:"success",
                    confirmButtonText:"确认",
                },function(){
                })
            }
            else{
                swal({title:"",
                    text:"已取消",
                    confirmButtonText:"确认",
                    type:"error"})
            }
        }
    )
}
