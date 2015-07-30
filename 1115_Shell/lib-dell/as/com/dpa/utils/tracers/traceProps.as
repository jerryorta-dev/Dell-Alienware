/**
 * Created with IntelliJ IDEA.
 * User: Jerry_Orta
 * Date: 5/23/13
 * Time: 12:21 PM
 * To change this template use File | Settings | File Templates.
 */
package com.dpa.utils.tracers {
import com.dpa.utils.objects.*;

    public function traceProps(obj:Object):void {
        for(var id:String in obj) {
            var value:Object = obj[id];
            if (typeof obj[id] === "object") {
                traceSubProp(id, obj[id]);
            } else if (typeof obj[id] === "array") {
                traceSubArray(id, obj[id])
            } else {
                trace(id + " = " + value);
            }
        }
    }



}
