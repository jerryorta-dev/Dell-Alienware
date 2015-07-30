/**
 * Created with IntelliJ IDEA.
 * User: jerryorta
 * Date: 12/9/12
 * Time: 5:18 PM
 * To change this template use File | Settings | File Templates.
 */
package com.dpa.utils.regexp {
    public function pushRegExpResultsIntoArray(str:String,  pattern:RegExp):Array {
        var resultArray:Array = new Array();
        var result:Object = pattern.exec(str);

        while (result != null) {
            resultArray.push(result[0]);
            result = pattern.exec(str);
        }

        return resultArray;
    }
}
