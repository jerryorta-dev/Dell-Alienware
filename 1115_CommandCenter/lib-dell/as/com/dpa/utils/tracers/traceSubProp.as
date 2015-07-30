/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/23/13
 * Time: 12:34 PM
 * To change this template use File | Settings | File Templates.
 */
package com.dpa.utils.tracers {

    public function traceSubProp(id:String, obj:Object):void {
            trace(id + ": Object = ")
            for(var id:String in obj) {
                var value:Object = obj[id];
                if (typeof obj[id] === "object") {
                    traceSubProp(id, obj[id]);
                } else if (typeof obj[id] === "array"){
                    traceSubArray(id, obj[id])
                } else {
                    trace("\t" + id + " = " + value);
                }
            }

    }

}
