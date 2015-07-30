package com.ooyala.api
{
  /**
  * Describes a video or a channel.
  */
  public class ContentItemDescription
  {
    private var _title:String;
    private var _description:String;
    private var _embedCode:String;
    private var _lineup:Array;
    private var _time:Number; // in seconds
    private var _promo:String;
    private var _hostedAtURL:String;

    public function get embedCode():String { return _embedCode; }

    public function get title():String { return _title; }

    public function get description():String { return _description; }

    public function get lineup():Array { return _lineup; }

    /**
    * Video length in seconds.
    */
    public function get time():Number { return _time; }

    public function get promo():String { return _promo; }

    /**
     * The URL of where the video is hosted on the web.
     */
    public function get hostedAtURL():String { return _hostedAtURL; }

    internal static function copyFrom(properties:Object):ContentItemDescription
    {
      const item:ContentItemDescription = new ContentItemDescription();
      item._embedCode = properties.embedCode;
      item._title = properties.title;
      item._description = properties.description;
      item._time = properties.time;
      item._promo = properties.promo;
      item._hostedAtURL = properties.hostedAtURL;

      const lineup:Array = properties.lineup;
      if (lineup)
      {
        item._lineup = [];
        for each (var lineupItem:Object in lineup)
        {
          item._lineup.push(ContentItemDescription.copyFrom(lineupItem));
        }
      }

      return item;
    }
  }
}
