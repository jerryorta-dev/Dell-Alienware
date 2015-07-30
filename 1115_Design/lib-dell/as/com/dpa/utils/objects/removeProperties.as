/**
 * Created with IntelliJ IDEA.
 * User: Jerry Orta
 * http://www.digitalproductionart.com
 * jerryorta@gmail.com
 *
 * Date: 11/21/12
 * Time: 8:21 AM
 */
package com.dpa.utils.objects
{

    public function removeProperties(vars:Object, properties:Array):Object {
        var len:int = properties.length;
        while(len--)
        {
            delete vars[properties[len]];
        }

        return vars;
    }

}
