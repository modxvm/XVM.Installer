{
  // Название секции может быть любым
  "battle": {
    // Название для TNewCheckListBox (обязательный параметр)
    "name": "Боевой интерфейс",
    // Задает отображение пункта, как radioButton, checkBox или group. Значение по умолчанию CheckBox
    "itemType": "checkBox",
    // true - пункт выбран. Значение по умолчанию true
    "checked": true,
    // Файл изображения, если выбран пункт. Значение по умолчанию "empty.png"
    "imagesIfSelected": "",
    // Файл изображения, если не выбран пункт. Значение по умолчанию "empty.png"
    "imagesIfNotSelected": "",
    // Значение, если выбран пункт. Если параметр равен "", то изменения в конфиг не вносятся. Значение по умолчанию "".
    "valueIfSelected": "",
    // Секция, если не выбран пункт. Если параметр равен "", то изменения в конфиг не вносятся. Значение по умолчанию "".
    "valueIfNotSelected": "",
    // В данной секции настраиваются дочерние пункты TNewCheckListBox
    "children": {
      // Название секции может быть любым
      "minimap": {
        "name": "Миникарта",
        "itemType": "checkBox",
        "checked": true,
        "imagesIfSelected": "minimap_true.png",
        "imagesIfNotSelected": "minimap_false.png",
        "valueIfSelected": "",
        "valueIfNotSelected": {
          // Название секции может быть любым
          "disabledMinimap": {
            // Файл конфигурации в который будут вносится изменения из секции "value"
            "configFileName": "minimap.xc",
            // Значение        
            "value": {
              "minimap": {
                "enabled": false
              }
            }
          }
        },
        "children": {
          "zoomMinimap": {
            "name": "Увеличение миникарты",
            "checked": true,
            "imagesIfSelected": "minimap_true.png",
            "imagesIfNotSelected": "minimap_true.png",
            "valueIfSelected": "",
            "valueIfNotSelected": {
              "centerMinimap": {
                "configFileName": "hotkeys.xc",
                "value": {
                  "hotkeys": {
                    "minimapZoom":{
                      "enabled": false
                    }
                  }
                }
              }
            },
            "children": {
              "zoomMinimap": {
                "name": "Увеличение по центру",
                "checked": false,
                "imagesIfSelected": "minimap_true.png",
                "imagesIfNotSelected": "minimap_true.png",
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
                }
              }
            }
          }
        }
      },
      "sixthSense": {
        "name": "Изображения для шестого чувства",
        "itemType": "group",
        "children": {
          "sixthSenseEye": {
            "name": "Глаз Саурона",
            "itemType": "radioButton",
            "checked": false,
            "imagesIfSelected": "SixthSense_Eye.png",
            "imagesIfNotSelected": "",
            "valueIfSelected": {
              "sixthSenseEye": {
                "@files": ["res_mods/mods/shared_resources/xvm/res/SixthSense_Eye.png"],
                "configFileName": "battle.xc",
                "value": {
                  "battle": {
                    "sixthSenseIcon": "xvm://res/SixthSense_Eye.png"
                  }
                }
              }
            },
            "valueIfNotSelected": ""
          },
          "sixthSenseSmile": {
            "name": "Смайлик",
            "itemType": "radioButton",
            "checked": false,
            "imagesIfSelected": "SixthSense_Smile.png",
            "imagesIfNotSelected": "",
            "valueIfSelected": {
              "sixthSenseEye": {
                "@files": ["res_mods/mods/shared_resources/xvm/res/SixthSense_Smile.png"],
                "configFileName": "battle.xc",
                "value": {
                  "battle": {
                    "sixthSenseIcon": "xvm://res/SixthSense_Smile.png"
                  }
                }
              }
            },
            "valueIfNotSelected": ""
          },
          "sixthSenseXVM": {
            "name": "Лампа XVM",
            "itemType": "radioButton",
            "checked": false,
            "imagesIfSelected": "SixthSense.png",
            "imagesIfNotSelected": "",
            "valueIfSelected": {
              "sixthSenseEye": {
                "@files": ["res_mods/mods/shared_resources/xvm/res/SixthSense.png"],
                "configFileName": "battle.xc",
                "value": {
                  "battle": {
                    "sixthSenseIcon": "xvm://res/SixthSense.png"
                  }
                }
              }
            },
            "valueIfNotSelected": ""
          },          
          "sixthSenseDefault": {
            "name": "Стандартная лампа",
            "itemType": "radioButton",
            "checked": true,
            "imagesIfSelected": "SixthSenseWG.png",
            "imagesIfNotSelected": "",
            "valueIfSelected": {
              "sixthSenseEye": {
                "configFileName": "battle.xc",
                "value": {
                  "battle": {
                    "sixthSenseIcon": ""
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
        "imagesIfSelected": "durationSixthSense_true.png",
        "imagesIfNotSelected": "durationSixthSense_false.png",
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
                  "format": "{{py:xvm.sixthSenseTimer(10)}}"
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
        "imagesIfSelected": "playersPanel_true.png",
        "imagesIfNotSelected": "playersPanel_false.png",
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
            "imagesIfSelected": "pp_stat_true.png",
            "imagesIfNotSelected": "pp_stat_false.png",        
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
        "imagesIfSelected": "showAliveNotFrags_true.png",
        "imagesIfNotSelected": "showAliveNotFrags_false.png",
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
      },
      "hitlog": {
        "name": "Лог нанесенного урона",
        "checked": true,
        "imagesIfSelected": "hitlog_true.png",
        "imagesIfNotSelected": "hitlog_false.png",
        "valueIfSelected": "",
        "valueIfNotSelected": {
          "hitlog_disabled": {
            "configFileName": "battleLabelsTemplates.xc",
            "value": {
              "def": {
                "hitlogBody": {
                  "enabled": false
                }
              }
            }
          }
        },
        "children": {
          "hitlog_header": {
            "name": "Общий заголовок (шапка)",
            "checked": false,
            "imagesIfSelected": "hitlog_header_true.png",
            "imagesIfNotSelected": "hitlog_true.png",
            "valueIfSelected": {
              "header_disabled": {
                "configFileName": "battleLabelsTemplates.xc",
                "value": {
                  "def": {
                    "hitlogHeader": {
                      "enabled": true
                    },
                    "totalEfficiency": {
                      "updateEvent": "PY(ON_TOTAL_EFFICIENCY)",
                      "screenVAlign": "bottom",
                      "x": 244,
                      "y": 0
                    }
                  }
                }
              }
            },
            "valueIfNotSelected": ""
          }
        }
      },
      "damageLog": {
        "name": "Лог полученного урона",
        "checked": true,
        "imagesIfSelected": "damageLog_true.png",
        "imagesIfNotSelected": "damageLog_false.png",
        "valueIfSelected": "",
        "valueIfNotSelected": {
          "damageLog_disabled": {
            "configFileName": "damageLog.xc",
            "value": {
              "damageLog": {
                "enabled": false
              }
            }
          }
        },
        "children": {
          "damageLog_bg": {
            "name": "Подложка лога полученного урона",
            "checked": false,
            "imagesIfSelected": "damageLog_bg_true.png",
            "imagesIfNotSelected": "damageLog_true.png",
            "valueIfSelected": {
              "bg_enabled": {
                "configFileName": "battleLabelsTemplates.xc",
                "value": {
                  "def": {
                    "damageLogBackground": {
                      "enabled": true
                    }
                  }
                }
              }
            },
            "valueIfNotSelected": ""
          }
        }
      },
      "totalEfficiency": {
        "name": "Панель эффективности",
        "checked": true,
        "imagesIfSelected": "totalEfficiency_true.png",
        "imagesIfNotSelected": "totalEfficiency_false.png",
        "valueIfSelected": "",
        "valueIfNotSelected": {
          "te_disabled": {
            "configFileName": "battleLabelsTemplates.xc",
            "value": {
              "def": {
                "totalEfficiency": {
                  "enabled": false
                }
              }
            }
          }
        }
      },
      "repairTime": {
        "name": "Таймер ремонта модулей",
        "checked": true,
        "imagesIfSelected": "repairTime_true.png",
        "imagesIfNotSelected": "repairTime_false.png",
        "valueIfSelected": "",
        "valueIfNotSelected": {
          "rt_disabled": {
            "configFileName": "battleLabelsTemplates.xc",
            "value": {
              "def": {
                "repairTimeEngine": {
                  "enabled": false
                },
                "repairTimeGun": {
                  "enabled": false
                },
                "repairTimeTurret": {
                  "enabled": false
                },
                "repairTimeTracks": {
                  "enabled": false
                },
                "repairTimeSurveying": {
                  "enabled": false
                },
                "repairTimeRadio": {
                  "enabled": false
                }
              }
            }
          }
        }
      },
      "hp_panel": {
        "name": "Индикатор общего ХП команд",
        "checked": true,
        "imagesIfSelected": "hp_panel_true.png",
        "imagesIfNotSelected": "hp_panel_false.png",
        "valueIfSelected": "",
        "valueIfNotSelected": {
          "hppl_disabled": {
            "configFileName": "battleLabelsTemplates.xc",
            "value": {
              "def": {
                "totalHP": {
                  "enabled": false
                }
              }
            }
          }
        },
        "children": {
          "avgDamage": {
            "name": "Средний урон на текущей технике",
            "checked": true,
            "imagesIfSelected": "avgDamage_true.png",
            "imagesIfNotSelected": "avgDamage_false.png",
            "valueIfSelected": "",
            "valueIfNotSelected": {
              "avgDamage_disabled": {
                "configFileName": "battleLabelsTemplates.xc",
                "value": {
                  "def": {
                    "avgDamage": {
                      "enabled": false
                    }
                  }
                }
              }
            }
          },
          "mainGun": {
            "name": "Урон для основного калибра",
            "checked": true,
            "imagesIfSelected": "mainGun_true.png",
            "imagesIfNotSelected": "mainGun_false.png",
            "valueIfSelected": "",
            "valueIfNotSelected": {
              "mainGun_disabled": {
                "configFileName": "battleLabelsTemplates.xc",
                "value": {
                  "def": {
                    "mainGun": {
                      "enabled": false
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  },
  "hangar": {
    "name": "Ангар",
    "checked": true,
    "children": {
      "widgets": {
        "name": "Виждеты",
        "checked": true,
        "children": {
          "clock_widgets": {
            "name": "Виждет часов",
            "checked": true,
            "imagesIfSelected": "clock_true.png",
            "imagesIfNotSelected": "clock_false.png",
            "valueIfSelected": {
              "clock_enabled": {
                "configFileName": "widgetsTemplates.xc",
                "value": {
                  "clock": {
                    "enabled": true
                  }
                }
              }
            },
            "valueIfNotSelected": {
              "clock_disabled": {
                "configFileName": "widgetsTemplates.xc",
                "value": {
                  "clock": {
                    "enabled": false
                  }
                }
              }
            }
          },
          "statistics_widgets": {
            "name": "Виждет статистики",
            "checked": true,
            "imagesIfSelected": "statistics_true.png",
            "imagesIfNotSelected": "statistics_false.png",
            "valueIfSelected": {
              "statistics_enabled": {
                "configFileName": "widgetsTemplates.xc",
                "value": {
                  "statistics": {
                    "enabled": true
                  }
                }
              }
            },
            "valueIfNotSelected": {
              "statistics_disabled": {
                "configFileName": "widgetsTemplates.xc",
                "value": {
                  "statistics": {
                    "enabled": false
                  }
                }
              }
            }
          }
        }
      }
    }
  },
  "sounds": {
    "name": "Звуки",
    "itemType": "checkBox",
    "checked": true,
    "imagesIfSelected": "",
    "imagesIfNotSelected": "",
    "valueIfSelected": "",
    "valueIfNotSelected": {
      "clock_disabled": {
        "configFileName": "sounds.xc",
        "value": {
          "sounds": {
            "enabled": false
          }
        }
      }
    },
    "children": {
      "sixthSense": {
        "name": "Озвучка перка шестого чувства",
        "checked": true,
        "imagesIfSelected": "",
        "imagesIfNotSelected": "",
        "valueIfSelected": "",
        "valueIfNotSelected": {
          "sixthSense_disabled": {
            "configFileName": "sounds.xc",
            "value": {
              "sounds": {
                "soundMapping": {
                  "lightbulb": "lightbulb",
                  "lightbulb_02": "lightbulb_02",
                  "sixthSense": "sixthSense",
                  "xvm_sixthSense": "",
                  "xvm_sixthSenseRudy": "",
                }
              }
            }
          }
        }
      }
    }
  }
}
