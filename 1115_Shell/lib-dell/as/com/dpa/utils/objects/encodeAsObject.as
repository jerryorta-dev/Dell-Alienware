/**
 * Created with IntelliJ IDEA.
 * User: jerryorta
 * Date: 11/21/12
 * Time: 4:58 PM
 * To change this template use File | Settings | File Templates.
 */
package com.dpa.utils.objects {

    import com.adobe.serialization.json.JSON_BC;

    /**
     * Take an object of a different type (class) and retype as a native Object.
     *
     * @param vars
     * @return
     */
    public function encodeAsObject(vars:*):Object {
        return com.adobe.serialization.json.JSON_BC.decode(com.adobe.serialization.json.JSON_BC.encode(vars));
    }

}
