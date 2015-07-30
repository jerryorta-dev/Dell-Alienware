package com.dpa.text{
    import com.dpa.text.StringUtil;

    import flash.utils.ByteArray;
    import flash.text.TextFormat;
    import flash.text.TextField;
    import flash.utils.ByteArray;
    import flash.utils.getQualifiedClassName;
    import flash.geom.Transform;
    import flash.display.DisplayObject;

    /**
     * http://graphnickdesign.com/blog/clone-objects-as3/
     */
    public class CloneTextObjects {
        public function CloneTextObjects(o:Object) {
            // constructor code
        }

        public static function clone(o:*):* {
            var type:String = StringUtil.getClassName(o);
            var obj:Object = getByteArray(o); // this returns null on MovieClips
            switch(type){
                case "TextFormat":
                default:
                    obj = parseFormat(obj);
                    break;
                case "TextField":
                    obj = parseTextField(obj,o);
                    break;
            }
            return obj;
        }

        private static function getByteArray(obj:Object):Object {
            var byteArray:ByteArray=new ByteArray();
            byteArray.writeObject(obj);
            byteArray.position = 0;
            return byteArray.readObject()
        }

        private static function parseFormat(_obj:Object):TextFormat{
            var _tf:TextFormat=new TextFormat();
            for (var prop:String in _obj){
                //trace(prop)
                _tf[prop]=_obj[prop]
            }
            return _tf;
        }

        private static function parseTextField(_obj:Object,o:TextField):TextField{
            var _textField:TextField =new TextField();
            for (var prop:String in _obj){
                if (prop=="transform"){
                    // actually setting transform properties becomes complex
                    _textField[prop] =new Transform(o);
                }else if (prop=="defaultTextFormat"){
                    _textField[prop] = parseFormat(_obj[prop]);
                }else{
                    try{
                        _textField[prop]=_obj[prop]
                    }catch(err:Error){
                        trace("Error Hit: "+err)
                    }
                }
            }
            return _textField;
        }
    }
}