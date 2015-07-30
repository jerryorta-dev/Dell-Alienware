/**
 * Created with IntelliJ IDEA.
 * User: Jerry Orta
 * http://www.digitalproductionart.com
 * jerryorta@gmail.com
 *
 * Date: 11/21/12
 * Time: 8:24 AM
 */
package com.dpa.utils.objects
{
    public function traceObjecProps(obj:Object):void {
        trace("Object Properties:");



        for (var i:* in obj) trace(i+" :: "+ obj[i]);

        //var description:XML = describeType(vars);
        //trace(description);
    }
}
