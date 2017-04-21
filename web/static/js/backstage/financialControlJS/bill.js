
/**
 * 初始化表格
 */
$(function () {
    initTable("table", "/chargeBill/queryByPager"); // 初始化表格
});


/**
 * 禁用激活
 * @param index
 * @param row
 * @returns {*}
 */
function statusFormatter(value) {
    /*处理数据*/
    if (value == 'Y') {
        return "&nbsp;&nbsp;激活";
    } else {
        return "&nbsp;&nbsp;禁用";
    }

}

/**
 * 操作禁用激活
 * @param index
 * @param row
 * @returns {string}
 */
function openStatusFormatter(value, row) {
    /*处理数据*/
    if (value == 'Y') {
        return "&nbsp;&nbsp;<a href='javascript:;' onclick='inactive(\"" + row.chargeBillId + "\")'>禁用</a>";
    } else {
        return "&nbsp;&nbsp;<a href='javascript:;' onclick='active(\"" + row.chargeBillId + "\")'>激活</a>";
    }

}


/**
 * 禁用支出类型
 * @param id
 */
function inactive(id) {
    $.post("/chargeBill/inactive?id=" + id,
        function (data) {
            if (data.result == "success") {
                $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
            }
        })
}


/**
 * 激活支出类型
 * @param id
 */
function active(id) {
    $.post("/chargeBill/active?id=" + id,
        function (data) {
            if (data.result == "success") {
                $('#table').bootstrapTable("refresh"); // 重新加载指定数据网格数据
            }
        })
}

/**
 * 查询禁用支出类型
 * @param id
 */
function searchDisableStatus() {
    initTable('table', '/chargeBill/queryByPagerDisable');
}

/**
 * 查询激活支出类型
 * @param id
 */
function searchRapidStatus() {
    initTable('table', '/chargeBill/queryByPager');
}

