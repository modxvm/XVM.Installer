{
  //Название секции может быть любым
  "minimap": {
    //Название для TNewCheckListBox (обязательный параметр)
    "name": "Миникарта",
    //задает отображение пункта, как radioButton, checkBox или group. Значение по умолчанию CheckBox
    "itemType": "checkBox",    //true - пункт выбран. Значение по умолчанию true
    "checked": true,
    //Файл изображения, если выбран пункт. Значение по умолчанию "empty.bmp"
    "imagesIfSelected": "minimap_true.bmp",
    //Файл изображения, если не выбран пункт. Значение по умолчанию "empty.bmp"
    "imagesIfNotSelected": "minimap_false.bmp",
    //Значение, если выбран пункт. Если параметр равен "", то изменения в конфиг не вносятся. Значение по умолчанию "".
    "valueIfSelected": "",
    // Секция, если не выбран пункт. Если параметр равен "", то изменения в конфиг не вносятся. Значение по умолчанию "".
    "valueIfNotSelected": {
      //Название секции может быть любым
      "disabledMinimap": {
        //Файл конфигурации в который будут вносится изменения из секции "value"
        "configFileName": "minimap.xc",
        //значение 
        "value": {
          "minimap": {
            "enabled": false
          }
        }
      }
    },
    // в данной секции настраиваются дочерние пункты TNewCheckListBox
    "children": {
      //Название секции может быть любым
      "zoom_minimap": {
        "name": "Увеличение миникарты",
        "checked": false,
        "imagesIfSelected": "minimap_true.bmp",
        "imagesIfNotSelected": "minimap_true.bmp",
        "valueIfSelected": {
          "centerMinimap": {
            "configFileName": "minimap.xc",
            "value": {
              "minimap": {
                "zoom":{
                  "centered": true
                }
              }
            }
          }
        },
        "valueIfNotSelected": ""
      }
    }
  },
  "durationSixthSense": {
    "name": "Таймер шестого чувства 10 сек",
    "checked": false,
    "imagesIfSelected": "fragCorrelation_true.bmp",
    "imagesIfNotSelected": "fragCorrelation_false.bmp",
    "valueIfSelected": {
      "refTimer": {
        //Параметр задает способ изменения конфига. По умолчанию true.
        //true -  значения массива добавляются.
        //false - массив полностью заменяется.
        "isAdd": true,
        //В данном параметре задаются через запятую файлы, которые необходимо скопировать в дирокторию игры.
        //В данном примере исходный файл расположен "SettingsInstall/default/files/res_mods/configs/xvm/py_macro/sixthSense.py".
        // Если пользователь выбрал данный пункт, то файл будет скопирован в "Каталог_игры/res_mods/configs/xvm/py_macro/sixthSense.py".
        "@files": ["res_mods/configs/xvm/py_macro/sixthSense.py"],
        "configFileName": "battleLabels.xc",
        "value": {
          "labels": {
            "formats": [${ "battleLabelsTemplates.xc":"def.sixthSenseTimer"}]
          }
        }
      },
      "timer": {
        "configFileName": "battleLabelsTemplates.xc",
        "value": {
          "def": {
            "sixthSenseTimer": {
              "enabled": true,
              "updateEvent": "PY(ON_SIXTH_SENSE_SHOW)",
              "x": 0,
              "y": "{{py:sub(-{{py:div({{py:xvm.screenHeight}}, 4)}}, 14)}}",
              "width": 60,
              "height": 50,
              "screenHAlign": "center",
              "screenVAlign": "center",
              "textFormat": {"align": "center", "size": 40 },
              "format": "{{py:xvm.sixthSenseTimer(10)})}}"
            }
          }
        }
      },

      "duretionImage": {
        "configFileName": "battle.xc",
        "value": {
          "battle": {
            "sixthSenseDuration": 10000
          }
        }
      }      
    },
    "valueIfNotSelected": ""
  },
  "playersPanel": {
    "name": "Панель игроков",
    "checked": true,
    "imagesIfSelected": "playersPanel_true.bmp",
    "imagesIfNotSelected": "playersPanel_false.bmp",
    "valueIfSelected": "",
    "valueIfNotSelected": {
      "disabledPlayersPanel": {
        "configFileName": "playersPanel.xc",
        "value": {
          "playersPanel": {
            "enabled": false
          }
        }
      }
    },
    "children": {
      "statistics": {
        "isCheckBox": true,
        "name": "Отображение статистики",
        "checked": true,
        "imagesIfSelected": "pp_stat_true.bmp",
        "imagesIfNotSelected": "pp_stat_false.bmp",        
        "valueIfSelected": "",
        "valueIfNotSelected": {
          "notDisplayStatistic": {
            "configFileName": "playersPanel.xc",
            "value":{
              "playersPanel": {
                "medium":{
                  "nickFormatLeft": "<font alpha='{{alive?#FF|#80}}'>{{name%.12s~..}}</font> <font alpha='#A0'>{{clan}}</font>",
                  "nickFormatRight": "<font alpha='#A0'>{{clan}}</font> <font alpha='{{alive?#FF|#80}}'>{{name%.12s~..}}</font>"
                },
                "medium2":{
                  "vehicleFormatLeft": "<font alpha='{{alive?#FF|#80}}'>{{vehicle}}</font>",
                  "vehicleFormatRight": "<font alpha='{{alive?#FF|#80}}'>{{vehicle}}</font>"
                },
                "large":{
                  "nickFormatLeft": "{{name%.15s~..}}<font alpha='#A0'>{{clan}}</font>",
                  "nickFormatRight": "<font alpha='#A0'>{{clan}}</font>{{name%.15}~..}}"
                }
              }
            }
          }
        }
      }
    }
  },
  "fragCorrelation": {
    "name": "Отображать живых на панели счета",
    "checked": false,
    "imagesIfSelected": "fragCorrelation_true.bmp",
    "imagesIfNotSelected": "fragCorrelation_false.bmp",
    "valueIfSelected": {
      "showAlive": {
        "configFileName": "battle.xc",
        "value": {
          "fragCorrelation": {
            "showAliveNotFrags": true
          }
        }
      }
    },
    "valueIfNotSelected": ""
  }
}
