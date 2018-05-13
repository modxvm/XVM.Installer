{
  // Название секции может быть любым
  "battle": {
    // Название для TNewCheckListBox (обязательный параметр)
    "name": "Боевой интерфейс",
    // Задает отображение пункта, как radioButton, checkBox или group. Значение по умолчанию CheckBox
    "itemType": "checkBox",
    // true - пункт выбран. Значение по умолчанию true
    "checked": true,
    // Файл изображения, если выбран пункт. Значение по умолчанию "empty.bmp"
    "imagesIfSelected": "",
    // Файл изображения, если не выбран пункт. Значение по умолчанию "empty.bmp"
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
        "imagesIfSelected": "minimap_true.bmp",
        "imagesIfNotSelected": "minimap_false.bmp",
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
        "imagesIfSelected": "durationSixthSense_true.bmp",
        "imagesIfNotSelected": "durationSixthSense_false.bmp",
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
      },
      "hitlog": {
        "name": "Лог нанесенного урона",
        "checked": true,
        "imagesIfSelected": "",
        "imagesIfNotSelected": "",
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
            "imagesIfSelected": "",
            "imagesIfNotSelected": "",
            "valueIfSelected": {
              "header_disabled": {
                "configFileName": "battleLabelsTemplates.xc",
                "value": {
                  "def": {
                    "hitlogHeader": {
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
      "damageLog": {
        "name": "Лог полученного урона",
        "checked": true,
        "imagesIfSelected": "",
        "imagesIfNotSelected": "",
        "valueIfSelected": "",
        "valueIfNotSelected": {
          "damageLog_disabled": {
            "configFileName": "damageLog.xc",
            "value": {
              "damageLog": {
                "enabled": false
              }
            }
          },
          "damageLog_bl_disabled": {
            "configFileName": "battleLabelsTemplates.xc",
            "value": {
              "def": {
                "damageLog": {
                  "enabled": false
                },
                "lastHit": {
                  "enabled": false
                }
              }
            }
          }
        },
        "children": {
          "wg_DetailStats": {
            "name": "Отключить стандартный детальный урон",
            "checked": true,
            "imagesIfSelected": "",
            "imagesIfNotSelected": "",
            "valueIfSelected": "",
            "valueIfNotSelected": {
              "wgds_enabled": {
                "configFileName": "damageLog.xc",
                "value": {
                  "damageLog": {
                    "disabledDetailStats": false
                  }
                }
              }
            }
          },
          "wg_SummaryStats": {
            "name": "Отключить стандартный суммарный урон",
            "checked": true,
            "imagesIfSelected": "",
            "imagesIfNotSelected": "",
            "valueIfSelected": "",
            "valueIfNotSelected": {
              "wgss_enabled": {
                "configFileName": "damageLog.xc",
                "value": {
                  "damageLog": {
                    "disabledSummaryStats": false
                  }
                }
              }
            }
          },
          "damageLog_bg": {
            "name": "Подложка лога полученного урона",
            "checked": false,
            "imagesIfSelected": "",
            "imagesIfNotSelected": "",
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
        "imagesIfSelected": "",
        "imagesIfNotSelected": "",
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
        "imagesIfSelected": "",
        "imagesIfNotSelected": "",
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
        "imagesIfSelected": "",
        "imagesIfNotSelected": "",
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
            "imagesIfSelected": "",
            "imagesIfNotSelected": "",
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
            "imagesIfSelected": "",
            "imagesIfNotSelected": "",
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
    "imagesIfSelected": "",
    "imagesIfNotSelected": "",
    "valueIfSelected": "",
    "valueIfNotSelected": "",
    "children": {
      "widgets": {
        "name": "Виждеты",
        "checked": true,
        "imagesIfSelected": "",
        "imagesIfNotSelected": "",
        "valueIfSelected": "",
        "valueIfNotSelected": "",
        "children": {
          "clock_widgets": {
            "name": "Виждет часов",
            "checked": true,
            "imagesIfSelected": "",
            "imagesIfNotSelected": "",
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
            "imagesIfSelected": "",
            "imagesIfNotSelected": "",
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
