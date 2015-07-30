/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/23/13
 * Time: 12:39 PM
 * To change this template use File | Settings | File Templates.
 */
package com.dpa.utils.tracers {
public function traceSubArray(id:String, array:String):void {
    trace(id + ": Array = ")
    var len:int = array.length;
    for (var i:int = 0; i < len; i++) {
        trace("\t" + array[i]);
    }
}
}
