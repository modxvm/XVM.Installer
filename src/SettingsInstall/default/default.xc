{
  // Название секции может быть любым
  "battle": {
    // Название для TNewCheckListBox (обязательный параметр)
    "name": "battle_interface",
    // Задает отображение пункта, как radioButton, checkBox или group. Значение по умолчанию CheckBox
    "itemType": "checkBox",
    // true - пункт выбран. Значение по умолчанию true
    "checked": true,
    // Файл изображения, если выбран пункт. Значение по умолчанию "empty.png"
    "imageIfSelected": "",
    // Файл изображения, если не выбран пункт. Значение по умолчанию "empty.png"
    "imageIfNotSelected": "",
    // Значение, если выбран пункт. Если параметр равен "", то изменения в конфиг не вносятся. Значение по умолчанию "".
    "valueIfSelected": "",
    // Секция, если не выбран пункт. Если параметр равен "", то изменения в конфиг не вносятся. Значение по умолчанию "".
    "valueIfNotSelected": "",
    // В данной секции настраиваются дочерние пункты TNewCheckListBox
    "children": {
      // Название секции может быть любым
      "minimap": {
        "name": "minimap",
        "itemType": "checkBox",
        "checked": true,
        "imageIfSelected": "minimap_true.png",
        "imageIfNotSelected": "minimap_false.png",
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
            "name": "increase_minimap",
            "checked": true,
            "imageIfSelected": "minimap_true.png",
            "imageIfNotSelected": "minimap_true.png",
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
                "name": "increase_center",
                "checked": false,
                "imageIfSelected": "minimap_true.png",
                "imageIfNotSelected": "minimap_true.png",
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
        "name": "images_for_sixth_sense",
        "itemType": "group",
        "children": {
          "sixthSenseEye": {
            "name": "eye_Sauron",
            "itemType": "radioButton",
            "checked": false,
            "imageIfSelected": "SixthSense_Eye.png",
            "imageIfNotSelected": "",
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
            "name": "smiley",
            "itemType": "radioButton",
            "checked": false,
            "imageIfSelected": "SixthSense_Smile.png",
            "imageIfNotSelected": "",
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
            "name": "lamp_XVM",
            "itemType": "radioButton",
            "checked": false,
            "imageIfSelected": "SixthSense.png",
            "imageIfNotSelected": "",
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
            "name": "standard_lamp",
            "itemType": "radioButton",
            "checked": true,
            "imageIfSelected": "SixthSenseWG.png",
            "imageIfNotSelected": "",
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
        "name": "sixth_sense_timer",
        "checked": false,
        "imageIfSelected": "durationSixthSense_true.png",
        "imageIfNotSelected": "durationSixthSense_false.png",
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
        "name": "players_panel",
        "checked": true,
        "imageIfSelected": "playersPanel_true.png",
        "imageIfNotSelected": "playersPanel_false.png",
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
            "name": "displaying_statistics",
            "checked": true,
            "imageIfSelected": "pp_stat_true.png",
            "imageIfNotSelected": "pp_stat_false.png",        
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
        "name": "display_live",
        "checked": false,
        "imageIfSelected": "showAliveNotFrags_true.png",
        "imageIfNotSelected": "showAliveNotFrags_false.png",
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
        "name": "hitlog",
        "checked": true,
        "imageIfSelected": "hitlog_true.png",
        "imageIfNotSelected": "hitlog_false.png",
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
            "name": "hitlog_header",
            "checked": false,
            "imageIfSelected": "hitlog_header_true.png",
            "imageIfNotSelected": "hitlog_true.png",
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
        "name": "damagelog",
        "checked": true,
        "imageIfSelected": "damageLog_true.png",
        "imageIfNotSelected": "damageLog_false.png",
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
            "name": "background",
            "checked": false,
            "imageIfSelected": "damageLog_bg_true.png",
            "imageIfNotSelected": "damageLog_true.png",
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
        "name": "panel_efficiency",
        "checked": true,
        "imageIfSelected": "totalEfficiency_true.png",
        "imageIfNotSelected": "totalEfficiency_false.png",
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
        "name": "timer_repair_modules",
        "checked": true,
        "imageIfSelected": "repairTime_true.png",
        "imageIfNotSelected": "repairTime_false.png",
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
        "name": "indicator_amount_HP_commands",
        "checked": true,
        "imageIfSelected": "hp_panel_true.png",
        "imageIfNotSelected": "hp_panel_false.png",
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
            "name": "average_damage_on_current_vehicle",
            "checked": true,
            "imageIfSelected": "avgDamage_true.png",
            "imageIfNotSelected": "avgDamage_false.png",
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
            "name": "damage_to_main_caliber",
            "checked": true,
            "imageIfSelected": "mainGun_true.png",
            "imageIfNotSelected": "mainGun_false.png",
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
        "name": "panel_after_death",
        "checked": true,
        "imageIfSelected": "",
        "imageIfNotSelected": "",
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
        "name": "camera_settings",
        "checked": false,
        "imageIfSelected": "",
        "imageIfNotSelected": "",
        "valueIfSelected": "",
        "valueIfNotSelected": "",
        "children": {
          "zoomIndicator": {
            "name": "zoom_indicator",
            "checked": true,
            "imageIfSelected": "zoomIndicator_true.png",
            "imageIfNotSelected": "zoomIndicator_false.png",
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
            "name": "red_flash_when_taking_damage",
            "checked": true,
            "imageIfSelected": "",
            "imageIfNotSelected": "",
            "valueIfSelected": "",
            "valueIfNotSelected": {
              "nfb_enabled": {
                "configFileName": "camera.xc",
                "value": {
                  "camera": {
                    "noFlashBang": true
                  }
                }
              }
            }
          },
          "hideHint": {
            "name": "tips_siege_mode_SPG_mode",
            "checked": true,
            "imageIfSelected": "hideHint_true.png",
            "imageIfNotSelected": "hideHint_false.png",
            "valueIfSelected": "",
            "valueIfNotSelected": {
              "hh_enabled": {
                "configFileName": "camera.xc",
                "value": {
                  "camera": {
                    "hideHint": true
                  }
                }
              }
            }
          },
          "noBinoculars": {
            "name": "blackout_sniper_mode",
            "checked": true,
            "imageIfSelected": "noBinoculars_true.png",
            "imageIfNotSelected": "noBinoculars_false.png",
            "valueIfSelected": "",
            "valueIfNotSelected": {
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
            }
          },
          "shotRecoilEffect": {
            "name": "effect_of_kickback",
            "checked": true,
            "imageIfSelected": "",
            "imageIfNotSelected": "",
            "valueIfSelected": "",
            "valueIfNotSelected": {
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
            }
          },
          "noCameraLimit": {
            "name": "camera_rotation_limit",
            "checked": true,
            "imageIfSelected": "",
            "imageIfNotSelected": "",
            "valueIfSelected": "",
            "valueIfNotSelected": {
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
            }
          }
        }
      }
    }
  },
  "hangar": {
    "name": "hangar",
    "checked": true,
    "children": {
      "widgets": {
        "name": "widgets",
        "checked": true,
        "children": {
          "clock_widgets": {
            "name": "clock",
            "checked": true,
            "imageIfSelected": "clock_true.png",
            "imageIfNotSelected": "clock_false.png",
            "valueIfSelected": "",
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
            "name": "account_stats",
            "checked": true,
            "imageIfSelected": "statistics_true.png",
            "imageIfNotSelected": "statistics_false.png",
            "valueIfSelected": "",
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
        "name": "ping_servers",
        "checked": false,
        "imageIfSelected": "",
        "imageIfNotSelected": "",
        "valueIfSelected": "",
        "valueIfNotSelected": "",
        "children": {
          "ping_login": {
            "name": "on_login_screen",
            "checked": false,
            "imageIfSelected": "",
            "imageIfNotSelected": "",
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
            "name": "in_hangar",
            "checked": false,
            "imageIfSelected": "",
            "imageIfNotSelected": "",
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
        "name": "online_servers",
        "checked": false,
        "imageIfSelected": "",
        "imageIfNotSelected": "",
        "valueIfSelected": "",
        "valueIfNotSelected": "",
        "children": {
          "online_login": {
            "name": "on_login_screen",
            "checked": false,
            "imageIfSelected": "",
            "imageIfNotSelected": "",
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
            "name": "in_hangar",
            "checked": false,
            "imageIfSelected": "",
            "imageIfNotSelected": "",
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
        "name": "save_last_server",
        "checked": false,
        "imageIfSelected": "",
        "imageIfNotSelected": "",
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
        "valueIfNotSelected": ""
      },
      "autologin": {
        "name": "automatic_login_to_game",
        "checked": false,
        "imageIfSelected": "",
        "imageIfNotSelected": "",
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
  },
  "color_theme": {
    "name": "color_scheme",
    "itemType": "group",
    "checked": false,
    "children": {
      "color_blindness": {
        "name": "color_blindness",
        "checked": false,
        "imageIfSelected": "color_blindness_true.png",
        "imageIfNotSelected": "color_blindness_false.png",
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
    "name": "sounds",
    "itemType": "checkBox",
    "checked": true,
    "imageIfSelected": "",
    "imageIfNotSelected": "",
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
        "name": "sixth_sense",
        "checked": true,
        "imageIfSelected": "",
        "imageIfNotSelected": "",
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
