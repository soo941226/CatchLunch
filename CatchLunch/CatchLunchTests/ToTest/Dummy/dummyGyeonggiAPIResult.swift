//
//  dummyData.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/03/02.
//

let dummyGyeonggiAPIResult = """
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
                    "REPRSNT_FOOD_NM": "마르게리따 피자",
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
                },
                {
                    "SIGUN_NM": "평택시",
                    "SIGUN_CD": "41220",
                    "RESTRT_NM": "고려정",
                    "REPRSNT_FOOD_NM": "한우한마리, 한우불고기전골",
                    "TASTFDPLC_TELNO": "031-657-8484",
                    "RM_MATR": null,
                    "REFINE_LOTNO_ADDR": "경기도 평택시 비전동 603-2번지",
                    "REFINE_ROADNM_ADDR": "경기도 평택시 평택3로 75",
                    "REFINE_ZIP_CD": "17896",
                    "REFINE_WGS84_LOGT": "127.0942568",
                    "REFINE_WGS84_LAT": "36.9956859"
                },
                {
                    "SIGUN_NM": "평택시",
                    "SIGUN_CD": "41220",
                    "RESTRT_NM": "㈜푸른소 경복궁",
                    "REPRSNT_FOOD_NM": "생갈비코스",
                    "TASTFDPLC_TELNO": "031-655-0567",
                    "RM_MATR": null,
                    "REFINE_LOTNO_ADDR": "경기도 평택시 합정동 914-3번지",
                    "REFINE_ROADNM_ADDR": "경기도 평택시 조개터로26번길 64",
                    "REFINE_ZIP_CD": "17904",
                    "REFINE_WGS84_LOGT": "127.1053125",
                    "REFINE_WGS84_LAT": "36.9886034"
                },
                {
                    "SIGUN_NM": "포천시",
                    "SIGUN_CD": "41650",
                    "RESTRT_NM": "참나무쟁이",
                    "REPRSNT_FOOD_NM": "진지상",
                    "TASTFDPLC_TELNO": "031-531-7970",
                    "RM_MATR": null,
                    "REFINE_LOTNO_ADDR": "경기도 포천시 내촌면 내리 267번지",
                    "REFINE_ROADNM_ADDR": "경기도 포천시 내촌면 금강로 2458",
                    "REFINE_ZIP_CD": "11189",
                    "REFINE_WGS84_LOGT": "127.2335517",
                    "REFINE_WGS84_LAT": "37.7945643"
                },
                {
                    "SIGUN_NM": "포천시",
                    "SIGUN_CD": "41650",
                    "RESTRT_NM": "명지원",
                    "REPRSNT_FOOD_NM": "이동갈비",
                    "TASTFDPLC_TELNO": "031-536-9919",
                    "RM_MATR": null,
                    "REFINE_LOTNO_ADDR": "경기도 포천시 일동면 화대리 367-5번지",
                    "REFINE_ROADNM_ADDR": "경기도 포천시 일동면 화동로 1258",
                    "REFINE_ZIP_CD": "11118",
                    "REFINE_WGS84_LOGT": "127.3308194",
                    "REFINE_WGS84_LAT": "37.9719342"
                },
                {
                    "SIGUN_NM": "포천시",
                    "SIGUN_CD": "41650",
                    "RESTRT_NM": "동이손만두",
                    "REPRSNT_FOOD_NM": "만두전골",
                    "TASTFDPLC_TELNO": "031-541-6870",
                    "RM_MATR": null,
                    "REFINE_LOTNO_ADDR": "경기도 포천시 소흘읍 직동리 376-2번지",
                    "REFINE_ROADNM_ADDR": "경기도 포천시 소흘읍 광릉수목원로 700-5",
                    "REFINE_ZIP_CD": "11186",
                    "REFINE_WGS84_LOGT": "127.1583588",
                    "REFINE_WGS84_LAT": "37.7735963"
                },
                {
                    "SIGUN_NM": "포천시",
                    "SIGUN_CD": "41650",
                    "RESTRT_NM": "대복 복전문점",
                    "REPRSNT_FOOD_NM": "복매운탕",
                    "TASTFDPLC_TELNO": "031-535-0303",
                    "RM_MATR": null,
                    "REFINE_LOTNO_ADDR": "경기도 포천시 선단동 505-9번지",
                    "REFINE_ROADNM_ADDR": "경기도 포천시 호국로964번길 12",
                    "REFINE_ZIP_CD": "11162",
                    "REFINE_WGS84_LOGT": "127.1651436",
                    "REFINE_WGS84_LAT": "37.8502215"
                },
                {
                    "SIGUN_NM": "포천시",
                    "SIGUN_CD": "41650",
                    "RESTRT_NM": "부용원",
                    "REPRSNT_FOOD_NM": "연잎밥한정식",
                    "TASTFDPLC_TELNO": "031-542-1981",
                    "RM_MATR": null,
                    "REFINE_LOTNO_ADDR": "경기도 포천시 소흘읍 고모리 676-7번지",
                    "REFINE_ROADNM_ADDR": "경기도 포천시 소흘읍 죽엽산로 452",
                    "REFINE_ZIP_CD": "11185",
                    "REFINE_WGS84_LOGT": "127.1648965",
                    "REFINE_WGS84_LAT": "37.7943724"
                },
                {
                    "SIGUN_NM": "포천시",
                    "SIGUN_CD": "41650",
                    "RESTRT_NM": "무봉리토종순대국(본점)",
                    "REPRSNT_FOOD_NM": "토종순대국",
                    "TASTFDPLC_TELNO": "031-542-4464",
                    "RM_MATR": null,
                    "REFINE_LOTNO_ADDR": "경기도 포천시 소흘읍 이동교리 84-1번지",
                    "REFINE_ROADNM_ADDR": "경기도 포천시 소흘읍 호국로 475",
                    "REFINE_ZIP_CD": "11184",
                    "REFINE_WGS84_LOGT": "127.1353350",
                    "REFINE_WGS84_LAT": "37.8151221"
                },
                {
                    "SIGUN_NM": "포천시",
                    "SIGUN_CD": "41650",
                    "RESTRT_NM": "대대손손묵집",
                    "REPRSNT_FOOD_NM": "대대손손묵집 정식",
                    "TASTFDPLC_TELNO": "031-542-6898",
                    "RM_MATR": null,
                    "REFINE_LOTNO_ADDR": "경기도 포천시 소흘읍 고모리 221-6번지",
                    "REFINE_ROADNM_ADDR": "경기도 포천시 소흘읍 죽엽산로447번길 11-3",
                    "REFINE_ZIP_CD": "11185",
                    "REFINE_WGS84_LOGT": "127.1665879",
                    "REFINE_WGS84_LAT": "37.7942619"
                },
                {
                    "SIGUN_NM": "포천시",
                    "SIGUN_CD": "41650",
                    "RESTRT_NM": "허브아일랜드 아테네홀",
                    "REPRSNT_FOOD_NM": "허브돈까스,허브비빔밥",
                    "TASTFDPLC_TELNO": "031-353-1174",
                    "RM_MATR": null,
                    "REFINE_LOTNO_ADDR": "경기도 포천시 신북면 삼정리 517-2번지",
                    "REFINE_ROADNM_ADDR": "경기도 포천시 신북면 청신로947번길 35",
                    "REFINE_ZIP_CD": "11137",
                    "REFINE_WGS84_LOGT": "127.1316099",
                    "REFINE_WGS84_LAT": "37.9652936"
                },
                {
                    "SIGUN_NM": "포천시",
                    "SIGUN_CD": "41650",
                    "RESTRT_NM": "상황버섯향촌",
                    "REPRSNT_FOOD_NM": "상황버섯삼계탕",
                    "TASTFDPLC_TELNO": "031-535-0005",
                    "RM_MATR": null,
                    "REFINE_LOTNO_ADDR": "경기도 포천시 군내면 하성북리 673번지",
                    "REFINE_ROADNM_ADDR": "경기도 포천시 군내면 포천로 1540",
                    "REFINE_ZIP_CD": "11151",
                    "REFINE_WGS84_LOGT": "127.2073337",
                    "REFINE_WGS84_LAT": "37.8964458"
                },
                {
                    "SIGUN_NM": "하남시",
                    "SIGUN_CD": "41450",
                    "RESTRT_NM": "지호 한방 삼계탕",
                    "REPRSNT_FOOD_NM": "삼계탕",
                    "TASTFDPLC_TELNO": "031-795-9996",
                    "RM_MATR": null,
                    "REFINE_LOTNO_ADDR": "경기도 하남시 풍산동 234-2번지",
                    "REFINE_ROADNM_ADDR": "경기도 하남시 하남대로 995",
                    "REFINE_ZIP_CD": "12984",
                    "REFINE_WGS84_LOGT": "127.1885317",
                    "REFINE_WGS84_LAT": "37.5475360"
                },
                {
                    "SIGUN_NM": "하남시",
                    "SIGUN_CD": "41450",
                    "RESTRT_NM": "한채당",
                    "REPRSNT_FOOD_NM": "궁중한정식",
                    "TASTFDPLC_TELNO": "031-792-8880",
                    "RM_MATR": null,
                    "REFINE_LOTNO_ADDR": "경기도 하남시 미사동 297번지",
                    "REFINE_ROADNM_ADDR": "경기도 하남시 미사동로 38",
                    "REFINE_ZIP_CD": "12900",
                    "REFINE_WGS84_LOGT": "127.2015046",
                    "REFINE_WGS84_LAT": "37.5706521"
                },
                {
                    "SIGUN_NM": "하남시",
                    "SIGUN_CD": "41450",
                    "RESTRT_NM": "하남미소 명품한우",
                    "REPRSNT_FOOD_NM": "꽃등심",
                    "TASTFDPLC_TELNO": "031-699-0002",
                    "RM_MATR": null,
                    "REFINE_LOTNO_ADDR": "경기도 하남시 신장동 522-4번지",
                    "REFINE_ROADNM_ADDR": "경기도 하남시 대청로 27",
                    "REFINE_ZIP_CD": "12947",
                    "REFINE_WGS84_LOGT": "127.2151395",
                    "REFINE_WGS84_LAT": "37.5409320"
                },
                {
                    "SIGUN_NM": "화성시",
                    "SIGUN_CD": "41590",
                    "RESTRT_NM": "홍천덤바우록계탕",
                    "REPRSNT_FOOD_NM": "록계탕",
                    "TASTFDPLC_TELNO": "031-366-7880",
                    "RM_MATR": null,
                    "REFINE_LOTNO_ADDR": "경기도 화성시 남양읍 남양리 2033-2번지",
                    "REFINE_ROADNM_ADDR": "경기도 화성시 남양읍 역골중앙로41번길 42",
                    "REFINE_ZIP_CD": "18271",
                    "REFINE_WGS84_LOGT": "126.8277703",
                    "REFINE_WGS84_LAT": "37.2062671"
                }
            ]
        }
    ]
}
"""
