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
            // Параметр задает способ изменения конфига. По умолчанию true.
            // true -  значения массива добавляются.
            // false - массив полностью заменяется.
            "isAdd": true,
            // В данном параметре задаются через запятую файлы, которые необходимо скопировать в директорию игры.
            // В данном примере исходный файл расположен "SettingsInstall/default/files/res_mods/configs/xvm/py_macro/sixthSense.py".
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
      },
      "postmortemTips": {
        "name": "Отключить всплывающую внизу панель после смерти",
        "checked": true,
        "imagesIfSelected": "",
        "imagesIfNotSelected": "",
        "valueIfSelected": "",
        "valueIfNotSelected": {
          "pt_disabled": {
            "configFileName": "battle.xc",
            "value": {
              "battle": {
                "showPostmortemTips": false
              }
            }
          }
        }
      },
      "camera": {
        "name": "Параметры камеры",
        "checked": false,
        "imagesIfSelected": "",
        "imagesIfNotSelected": "",
        "valueIfSelected": "",
        "valueIfNotSelected": "",
        "children": {
          "zoomIndicator": {
            "name": "Индикатор масштаба",
            "checked": true,
            "imagesIfSelected": "zoomIndicator_true.png",
            "imagesIfNotSelected": "zoomIndicator_false.png",
            "valueIfSelected": "",
            "valueIfNotSelected": {
              "szi_disabled": {
                "configFileName": "camera.xc",
                "value": {
                  "camera": {
                    "sniper": {
                      "zoomIndicator": {
                        "enabled": false
                      }
                    }
                  }
                }
              }
            }
          },
          "noFlashBang": {
            "name": "Отключить красную вспышку (враг попадает по вам)",
            "checked": false,
            "imagesIfSelected": "",
            "imagesIfNotSelected": "",
            "valueIfSelected": {
              "nfb_enabled": {
                "configFileName": "camera.xc",
                "value": {
                  "camera": {
                    "noFlashBang": true
                  }
                }
              }
            },
            "valueIfNotSelected": ""
          },
          "hideHint": {
            "name": "Cкрыть подсказки (переход в осадный режим, альт.режим АРТ-САУ)",
            "checked": false,
            "imagesIfSelected": "hideHint_true.png",
            "imagesIfNotSelected": "hideHint_false.png",
            "valueIfSelected": {
              "hh_enabled": {
                "configFileName": "camera.xc",
                "value": {
                  "camera": {
                    "hideHint": true
                  }
                }
              }
            },
            "valueIfNotSelected": ""
          },
          "noBinoculars": {
            "name": "Отключить затемнение и озеленение в снайперском прицеле",
            "checked": false,
            "imagesIfSelected": "noBinoculars_true.png",
            "imagesIfNotSelected": "noBinoculars_false.png",
            "valueIfSelected": {
              "snb_enabled": {
                "configFileName": "camera.xc",
                "value": {
                  "camera": {
                    "sniper": {
                      "noBinoculars": true
                    }
                  }
                }
              }
            },
            "valueIfNotSelected": ""
          },
          "shotRecoilEffect": {
            "name": "Отключить эффект отдачи от выстрела",
            "checked": false,
            "imagesIfSelected": "",
            "imagesIfNotSelected": "",
            "valueIfSelected": {
              "sre_disabled": {
                "configFileName": "camera.xc",
                "value": {
                  "camera": {
                    "arcade": {
                      "shotRecoilEffect": false
                    },
                    "postmortem": {
                      "shotRecoilEffect": false
                    },
                    "strategic": {
                      "shotRecoilEffect": false
                    },
                    "sniper": {
                      "shotRecoilEffect": false
                    }
                  }
                }
              }
            },
            "valueIfNotSelected": ""
          },
          "noCameraLimit": {
            "name": "Отключение предела вращения камеры (для техники с ограниченными УГН)",
            "checked": false,
            "imagesIfSelected": "",
            "imagesIfNotSelected": "",
            "valueIfSelected": {
              "ncl_enabled": {
                "configFileName": "camera.xc",
                "value": {
                  "camera": {
                    "sniper": {
                      "noCameraLimit": {
                        "enabled": true
                      }
                    }
                  }
                }
              }
            },
            "valueIfNotSelected": ""
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
      },
      "pingServers": {
        "name": "Пинг серверов",
        "checked": false,
        "imagesIfSelected": "",
        "imagesIfNotSelected": "",
        "valueIfSelected": "",
        "valueIfNotSelected": "",
        "children": {
          "ping_login": {
            "name": "На экране логина",
            "checked": false,
            "imagesIfSelected": "",
            "imagesIfNotSelected": "",
            "valueIfSelected": {
              "ping_enabled": {
                "configFileName": "login.xc",
                "value": {
                  "login": {
                    "pingServers": {
                      "enabled": true
                    }
                  }
                }
              }
            },
            "valueIfNotSelected": ""
          },
          "ping_hangar": {
            "name": "В ангаре",
            "checked": false,
            "imagesIfSelected": "",
            "imagesIfNotSelected": "",
            "valueIfSelected": {
              "ping_enabled": {
                "configFileName": "hangar.xc",
                "value": {
                  "hangar": {
                    "pingServers": {
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
      "onlineServers": {
        "name": "Онлайн серверов",
        "checked": false,
        "imagesIfSelected": "",
        "imagesIfNotSelected": "",
        "valueIfSelected": "",
        "valueIfNotSelected": "",
        "children": {
          "online_login": {
            "name": "На экране логина",
            "checked": false,
            "imagesIfSelected": "",
            "imagesIfNotSelected": "",
            "valueIfSelected": {
              "online_enabled": {
                "configFileName": "login.xc",
                "value": {
                  "login": {
                    "onlineServers": {
                      "enabled": true
                    }
                  }
                }
              }
            },
            "valueIfNotSelected": ""
          },
          "online_hangar": {
            "name": "В ангаре",
            "checked": false,
            "imagesIfSelected": "",
            "imagesIfNotSelected": "",
            "valueIfSelected": {
              "online_enabled": {
                "configFileName": "hangar.xc",
                "value": {
                  "hangar": {
                    "onlineServers": {
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
      "saveLastServer": {
        "name": "Сохранять последний сервер",
        "checked": false,
        "imagesIfSelected": "",
        "imagesIfNotSelected": "",
        "valueIfSelected": {
          "sls_enabled": {
            "configFileName": "login.xc",
            "value": {
              "login": {
                "saveLastServer": true
              }
            }
          }
        },
        "valueIfNotSelected": "",
        "children": {
          "autologin": {
            "name": "Автоматический вход в игру",
            "checked": false,
            "imagesIfSelected": "",
            "imagesIfNotSelected": "",
            "valueIfSelected": {
              "autologin_enabled": {
                "configFileName": "login.xc",
                "value": {
                  "login": {
                    "autologin": true
                  }
                }
              }
            },
            "valueIfNotSelected": ""
          }
        }
      }
    }
  },
  "color_theme": {
    "name": "Цветовая схема",
    "itemType": "group",
    "checked": false,
    "imagesIfSelected": "",
    "imagesIfNotSelected": "",
    "valueIfSelected": "",
    "valueIfNotSelected": "",
    "children": {
      "color_blindness": {
        "name": "Цветовая слепота",
        "checked": false,
        "imagesIfSelected": "color_blindness_true.png",
        "imagesIfNotSelected": "color_blindness_false.png",
        "valueIfSelected": {
          "cb_login": {
            "@files": [
              "res_mods/mods/shared_resources/xvm/res/icons/carousel/damage.png"
            ],
            "configFileName": "login.xc",
            "value": {
              "login": {
                "pingServers": {
                  "fontStyle": {
                    "color": {
                      "bad": "0x3399CC"
                    }
                  }
                },
                "onlineServers": {
                  "fontStyle": {
                    "color": {
                      "bad": "0x3399CC"
                    }
                  }
                }
              }
            }
          },
          "cb_hangar": {
            "configFileName": "hangar.xc",
            "value": {
              "hangar": {
                "pingServers": {
                  "fontStyle": {
                    "color": {
                      "bad": "0x3399CC"
                    }
                  }
                },
                "onlineServers": {
                  "fontStyle": {
                    "color": {
                      "bad": "0x3399CC"
                    }
                  }
                }
              }
            }
          },
          "cb_mm_circles": {
            "configFileName": "minimapCircles.xc",
            "isAdd": false,
            "value": {
              "circles": {
                "view": [
                  { "enabled":  true, "distance": "blindarea", "scale": 1, "thickness": 0.75, "alpha": 80, "color": "0x3EB5F1" },
                  { "enabled":  true, "distance": 445,         "scale": 1, "thickness":  1.1, "alpha": 45, "color": "0xFFCC66" },
                  { "enabled": "{{my-vtype-key=SPG?false|true}}", "distance": 564, "scale": 1, "thickness": 0.7, "alpha": 40, "color": "0xFFFFFF" },
                  { "enabled": true, "distance": 50,           "scale": 1, "thickness": 0.75, "alpha": 60, "color": "0xFFFFFF" },
                  { "enabled": false, "distance": "standing",  "scale": 1, "thickness":  1.0, "alpha": 60, "color": "0x887EFF" },
                  { "enabled": false, "distance": "motion",    "scale": 1, "thickness":  1.0, "alpha": 60, "color": "0x0000FF" },
                  { "enabled": false, "distance": "dynamic",   "scale": 1, "thickness":  1.0, "alpha": 60, "color": "0x3EB5F1" }
                ],
                "artillery": { "enabled": true, "alpha": 55, "color": "0x3C3C6D", "thickness": 0.5 },
                "shell": { "enabled": true, "alpha": 55, "color": "0x3C3C6D", "thickness": 0.5 }
              }
            }
          },
          "cb_mm_labels": {
            "configFileName": "minimapLabelsData.xc",
            "value": {
              "labelsData": {
                "colors": {
                  "txt": {
                    "enemy_alive": "#A8A4D7",
                    "enemy_dead": "#7F90A8",
                    "enemy_blowedup": "#7F90A8"
                  },
                  "dot": {
                    "enemy_alive": "#F50800",
                    "enemy_dead": "#47407A",
                    "enemy_blowedup": "#47407A"
                  },
                  "lostDot": {
                    "enemy_alive": "#A4ACD6",
                    "enemy_dead": "#47407A",
                    "enemy_blowedup": "#47407A"
                  }
                }
              }
            }
          },
          "damageLog_bg": {
            "configFileName": "damageLog.xc",
            "@files": ["res_mods/mods/shared_resources/xvm/res/icons/damageLog/cb_dmg.png"],
            "value": {
              "damageLog": {
                "logBackground": {
                  "formatHistory": "<img height='20' width='310' src='xvm://res/icons/damageLog/{{dmg=0?no_dmg|cb_dmg}}.png'>"
                },
                "logAltBackground": {
                  "formatHistory": "<img height='20' width='310' src='xvm://res/icons/damageLog/{{dmg=0?no_dmg|cb_dmg}}.png'>"
                }            
              }
            }
          },
          "cb_colors": {
            "configFileName": "colors.xc",
            "@files": ["res_mods/configs/xvm/py_macro/systemColor.py"],
            "value": {
              "def": {
                "en": "0x8379FE",
                "colorRating": {
                  "very_bad": "0x9C3E00"
                },
                "colorHP": {
                  "very_low": "0x3355CC",
                  "low": "0x3399CC"
                }
              },
              "colors": {
                "system": {
                  "enemy_dead": "0x47407A",
                  "enemy_blowedup": "0x3B365F"
                },
                "dmg_kind": {
                  "fire": "0x756CE0"
                },
                "vtype": {
                  "HT": "0x3399CC"
                }
              }
            }
          }
        },
        "valueIfNotSelected": ""
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
        // Имя звукового файла (mp3, ogg), который будет проигран, если пункт выбран. Значение по умолчанию ""
        "soundIfSelected": "sixthSenseXVM.mp3",
        // Имя звукового файла (mp3, ogg), который будет проигран, если пункт не выбран. Значение по умолчанию ""
        "soundIfNotSelected": "sixthSenseWoT_1.mp3",
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
