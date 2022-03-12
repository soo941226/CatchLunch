//
//  DummyGyeonggiAPIResult.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/03/02.
//

struct DummyGyeonggiAPIResult {
    let objectWithCount10 = """
    {
        "PlaceThatDoATasteyFoodSt": [
            {
                "head": [
                    {
                        "list_total_count": 137
                    },
                    {
                        "RESULT": {
                            "CODE": "INFO-000",
                            "MESSAGE": "정상 처리되었습니다."
                        }
                    },
                    {
                        "api_version": "1.0"
                    }
                ]
            },
            {
                "row": [
                    {
                        "SIGUN_NM": "의정부시",
                        "SIGUN_CD": "41150",
                        "RESTRT_NM": "핏제리아 루카",
                        "REPRSNT_FOOD_NM": "asjgbipfjspidfjgasipbfajsdfipgfajbipfsfjsdipfpidjaspiabfjndpis",
                        "TASTFDPLC_TELNO": "031-851-3589",
                        "RM_MATR": null,
                        "REFINE_LOTNO_ADDR": "경기도 의정부시 민락동 776-2번지",
                        "REFINE_ROADNM_ADDR": "경기도 의정부시 송현로82번길 17",
                        "REFINE_ZIP_CD": "11813",
                        "REFINE_WGS84_LOGT": "127.0904053",
                        "REFINE_WGS84_LAT": "37.7454846"
                    },
                    {
                        "SIGUN_NM": "이천시",
                        "SIGUN_CD": "41500",
                        "RESTRT_NM": "증포설렁탕",
                        "REPRSNT_FOOD_NM": "설렁탕, 도가니탕",
                        "TASTFDPLC_TELNO": "031-635-7877",
                        "RM_MATR": null,
                        "REFINE_LOTNO_ADDR": "경기도 이천시 증포동 368번지",
                        "REFINE_ROADNM_ADDR": "경기도 이천시 증신로 166",
                        "REFINE_ZIP_CD": "17346",
                        "REFINE_WGS84_LOGT": "127.4512903",
                        "REFINE_WGS84_LAT": "37.2902983"
                    },
                    {
                        "SIGUN_NM": "이천시",
                        "SIGUN_CD": "41500",
                        "RESTRT_NM": "도락",
                        "REPRSNT_FOOD_NM": "웰빙쌀밥정식",
                        "TASTFDPLC_TELNO": "031-638-3020",
                        "RM_MATR": null,
                        "REFINE_LOTNO_ADDR": "경기도 이천시 신둔면 소정리 49-1번지",
                        "REFINE_ROADNM_ADDR": "경기도 이천시 신둔면 황무로 485",
                        "REFINE_ZIP_CD": "17304",
                        "REFINE_WGS84_LOGT": "127.4029104",
                        "REFINE_WGS84_LAT": "37.3029868"
                    },
                    {
                        "SIGUN_NM": "파주시",
                        "SIGUN_CD": "41480",
                        "RESTRT_NM": "교하정",
                        "REPRSNT_FOOD_NM": "양념갈비,육회",
                        "TASTFDPLC_TELNO": "031-942-7788",
                        "RM_MATR": null,
                        "REFINE_LOTNO_ADDR": "경기도 파주시 교하동 617-12번지",
                        "REFINE_ROADNM_ADDR": "경기도 파주시 교하로 1290",
                        "REFINE_ZIP_CD": "10866",
                        "REFINE_WGS84_LOGT": "126.7369646",
                        "REFINE_WGS84_LAT": "37.7487308"
                    },
                    {
                        "SIGUN_NM": "파주시",
                        "SIGUN_CD": "41480",
                        "RESTRT_NM": "초계탕,춘천막국수",
                        "REPRSNT_FOOD_NM": "초계탕",
                        "TASTFDPLC_TELNO": "031-958-5250",
                        "RM_MATR": null,
                        "REFINE_LOTNO_ADDR": "경기도 파주시 법원읍 법원리 391-3번지",
                        "REFINE_ROADNM_ADDR": "경기도 파주시 법원읍 초리골길 110",
                        "REFINE_ZIP_CD": "10826",
                        "REFINE_WGS84_LOGT": "126.8893621",
                        "REFINE_WGS84_LAT": "37.8510263"
                    },
                    {
                        "SIGUN_NM": "파주시",
                        "SIGUN_CD": "41480",
                        "RESTRT_NM": "오두산막국수",
                        "REPRSNT_FOOD_NM": "메밀막국수",
                        "TASTFDPLC_TELNO": "031-941-5237",
                        "RM_MATR": null,
                        "REFINE_LOTNO_ADDR": "경기도 파주시 탄현면 성동리 674번지",
                        "REFINE_ROADNM_ADDR": "경기도 파주시 탄현면 성동로 17",
                        "REFINE_ZIP_CD": "10862",
                        "REFINE_WGS84_LOGT": "126.6867970",
                        "REFINE_WGS84_LAT": "37.7791671"
                    },
                    {
                        "SIGUN_NM": "파주시",
                        "SIGUN_CD": "41480",
                        "RESTRT_NM": "문산밤나무골",
                        "REPRSNT_FOOD_NM": "전복한방백숙, 오리로스",
                        "TASTFDPLC_TELNO": "031-952-5240",
                        "RM_MATR": null,
                        "REFINE_LOTNO_ADDR": "경기도 파주시 파주읍 봉서리 327-1번지",
                        "REFINE_ROADNM_ADDR": "경기도 파주시 파주읍 통일로 1604-144",
                        "REFINE_ZIP_CD": "10836",
                        "REFINE_WGS84_LOGT": "126.7942907",
                        "REFINE_WGS84_LAT": "37.8524369"
                    },
                    {
                        "SIGUN_NM": "파주시",
                        "SIGUN_CD": "41480",
                        "RESTRT_NM": "유일곰탕",
                        "REPRSNT_FOOD_NM": "곰탕",
                        "TASTFDPLC_TELNO": "031-944-3691",
                        "RM_MATR": null,
                        "REFINE_LOTNO_ADDR": "경기도 파주시 월롱면 위전리 430-27번지",
                        "REFINE_ROADNM_ADDR": "경기도 파주시 월롱면 다락고개길 119",
                        "REFINE_ZIP_CD": "10946",
                        "REFINE_WGS84_LOGT": "126.7910910",
                        "REFINE_WGS84_LAT": "37.7952484"
                    },
                    {
                        "SIGUN_NM": "파주시",
                        "SIGUN_CD": "41480",
                        "RESTRT_NM": "오백년누룽지백숙",
                        "REPRSNT_FOOD_NM": "닭 누룽지 백숙",
                        "TASTFDPLC_TELNO": "031-8071-6500",
                        "RM_MATR": null,
                        "REFINE_LOTNO_ADDR": "경기도 파주시 탄현면 성동리 94번지",
                        "REFINE_ROADNM_ADDR": "경기도 파주시 탄현면 새오리로 94",
                        "REFINE_ZIP_CD": "10858",
                        "REFINE_WGS84_LOGT": "126.6857754",
                        "REFINE_WGS84_LAT": "37.7924443"
                    },
                    {
                        "SIGUN_NM": "평택시",
                        "SIGUN_CD": "41220",
                        "RESTRT_NM": "해원",
                        "REPRSNT_FOOD_NM": "해원정식, 소담정식",
                        "TASTFDPLC_TELNO": "031-654-6696",
                        "RM_MATR": null,
                        "REFINE_LOTNO_ADDR": "경기도 평택시 동삭동 704-6번지",
                        "REFINE_ROADNM_ADDR": "경기도 평택시 비전2로 34",
                        "REFINE_ZIP_CD": "17849",
                        "REFINE_WGS84_LOGT": "127.0961688",
                        "REFINE_WGS84_LAT": "37.0067405"
                    }
                ]
            }
        ]
    }
    """.data(using: .utf8)!

    let objectWithCount0 = """
    {
        "PlaceThatDoATasteyFoodSt": [
            {
                "head": [
                    {
                        "list_total_count": 137
                    },
                    {
                        "RESULT": {
                            "CODE": "INFO-000",
                            "MESSAGE": "정상 처리되었습니다."
                        }
                    },
                    {
                        "api_version": "1.0"
                    }
                ]
            },
            {
                "row": []
            }
        ]
    }
    """.data(using: .utf8)!

    let objectWithWrongFormmat = """
    {
        "PlaceThatDoATasteyFoodSt": [
            {
                "head": [
                    {
                        "list_total_count": 137
                    },
                    {
                        "RESULT": {
                            "CODE": "INFO-000",
                            "MESSAGE": "정상 처리되었습니다."
                        }
                    },
                    {
                        "api_version": "1.0"
                    }
                ]
            },
            {
                "row": {a: 1}
            }
        ]
    }
    """.data(using: .utf8)!

    let emptyObject = "{}".data(using: .utf8)!
}
