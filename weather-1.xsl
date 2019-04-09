<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" doctype-system="about:legacy-compat"/>

    <xsl:template match="/">

        <!-- <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text> -->
        <html xmlns="http://www.w3.org/1999/xhtml">

            <head>
                <!-- <meta charset="utf-8"> -->
                <title>Weather</title>
                <link href="weather.css" rel="stylesheet"/>
            </head>

            <body>
                <main>

                    <input id="tab1" type="radio" name="tabs" checked="true"></input>
                    <label for="tab1">NSW and ACT Weather</label>

                    <input id="tab2" type="radio" name="tabs"></input>
                    <label for="tab2">Canberra Weather</label>

                    <input id="tab3" type="radio" name="tabs"></input>
                    <label for="tab3">Sydney Weather</label>

                    <input id="tab4" type="radio" name="tabs"></input>
                    <label for="tab4">Snowy Mountains District Weather</label>

                    <section id="content1">
                        <xsl:for-each select="product/forecast/area/forecast-period[@index=0]">
                            <article class="day">
                                <xsl:variable name="time" select="@start-time-local" />
                                <!-- <p>Forecast for the rest of <xsl:value-of select="format-dateTime(forecast-period[2]/@start-time-local,'[FNn] [D1] [MNn]','en',(),())" /></p>
                                <p><xsl:value-of select="forecast-period[2]/text[@type='forecast']"/></p> -->
                                <p>Forecast for the rest of <xsl:value-of select="format-dateTime($time,'[FNn] [D1] [MNn]')" /></p>
                                <p><xsl:value-of select="text[@type='forecast']"/></p>
                            </article>
                        </xsl:for-each>
                    </section>

                    <section id="content2">
                        <xsl:for-each select="document('xml-data/IDN10035.xml')/product/forecast/area[@type='metropolitan']/forecast-period">
                            <xsl:variable name="index" select="@index" />
                            <xsl:if test="$index &gt; 0 and $index &lt; 4">
                                <article class="day">
                                    <p>Forecast for <xsl:value-of select="format-dateTime(@start-time-local,'[FNn] [D1] [MNn]')" /></p>
                                    <p><xsl:value-of select="text[@type='forecast']"/></p>
                                    <p>Min: <xsl:value-of select="../../area[@type='location']/forecast-period[$index+1]/element[@type='air_temperature_minimum']"/></p>
                                    <p>Max: <xsl:value-of select="../../area[@type='location']/forecast-period[$index+1]/element[@type='air_temperature_maximum']"/></p>
                                </article>
                            </xsl:if>
                        </xsl:for-each>
                    </section>

                    <section id="content3">
                        <xsl:for-each select="document('xml-data/IDN11050.xml')/product/forecast/area[@description='Sydney']/forecast-period">
                            <xsl:variable name="index" select="@index" />
                            <xsl:if test="$index &gt; 0 and $index &lt; 4">
                                <article class="day">
                                    <p>Forecast for <xsl:value-of select="format-dateTime(@start-time-local,'[FNn] [D1] [MNn]')" /></p>
                                    <p><xsl:value-of select="text[@type='forecast']"/></p>
                                    <p>Min: <xsl:value-of select="document('xml-data/IDN11060.xml')/product/forecast/area[@description='Sydney']/forecast-period[$index+1]/element[@type='air_temperature_minimum']"/></p>
                                    <p>Max: <xsl:value-of select="document('xml-data/IDN11060.xml')/product/forecast/area[@description='Sydney']/forecast-period[$index+1]/element[@type='air_temperature_maximum']"/></p>
                                </article>
                            </xsl:if>
                        </xsl:for-each>
                    </section>

                    <section id="content4">
                        <xsl:for-each select="document('xml-data/IDN11032.xml')/product/forecast/area[@description='Snowy Mountains']/forecast-period">
                            <xsl:variable name="index" select="@index" />
                            <xsl:if test="$index &gt; 0 and $index &lt; 4">
                                <article class="day">
                                    <p>Forecast for <xsl:value-of select="format-dateTime(@start-time-local,'[FNn] [D1] [MNn]')" /></p>
                                    <p><xsl:value-of select="text[@type='forecast']"/></p>
                                    <p>Snow at <xsl:value-of select="element[@type='snow_elevation_3']"/> m: <xsl:value-of select="element[@type='probability_of_snow_at_elevation_3']"/>.</p>

                                    <div class="limiter">
                                        <div class="container-table100">
                                            <div class="wrap-table100">
                                                <div class="table">

                                                    <div class="row header">
                                                        <div class="cell">
                                                            Town
                                                        </div>
                                                        <div class="cell">
                                                            Forecast
                                                        </div>
                                                        <div class="cell">
                                                            Min
                                                        </div>
                                                        <div class="cell">
                                                            Max
                                                        </div>
                                                    </div>

                                                    <xsl:for-each select="../../*">
                                                        <xsl:sort select="@description"/>
                                                        <xsl:variable name="type" select="@type" />
                                                        <xsl:if test="$type = 'location'">

                                                            <div class="row">
                                                                <div class="cell" data-title="Town">
                                                                    <xsl:value-of select="@description"/>
                                                                </div>
                                                                <div class="cell" data-title="Forecast">
                                                                    <xsl:value-of select="forecast-period[$index+1]/text[@type='precis']"/>
                                                                </div>
                                                                <div class="cell" data-title="Min">
                                                                    <xsl:value-of select="forecast-period[$index+1]/element[@type='air_temperature_minimum']"/>
                                                                </div>
                                                                <div class="cell" data-title="Max">
                                                                    <xsl:value-of select="forecast-period[$index+1]/element[@type='air_temperature_maximum']"/>
                                                                </div>
                                                            </div>
                                                        </xsl:if>
                                                    </xsl:for-each>


                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </article>
                            </xsl:if>
                        </xsl:for-each>
                    </section>
                </main>
            </body>

        </html>

    </xsl:template>
                <!-- <section id="content2">
                    <xsl:for-each select="document('xml-data/IDN10035.xml')/product/forecast/area[@aac='NSW_ME006']/forecast-period">
                        <article class="day">
                            <p>Forecast for <xsl:value-of select="format-dateTime(@start-time-local,'[FNn] [D1] [MNn]','en',(),())" /></p>
                            <p><xsl:value-of select="text[@type='forecast']"/></p>
                        </article>
                    </xsl:for-each> -->
                    <!-- <article class="day partly-cloudy">
                        <p>
                            Forecast for Friday 27 April
                        </p>
                        <p>
                            Partly cloudy. Light winds becoming southeasterly 15 to 20 km/h in the morning then becoming light in the evening.
                        </p>
                        <p>
                            Min 8 Max 19
                        </p>
                    </article>
                    <article class="day cloudy">
                        <p>
                            Forecast for Saturday 28 April
                        </p>
                        <p>
                            Cloudy. Light winds becoming southeasterly 15 to 20 km/h in the early afternoon then becoming light in the evening.
                        </p>
                        <p>
                            Min 3 Max 18
                        </p>
                    </article>
                    <article class="day partly-cloudy">
                        <p>
                            Forecast for Sunday 29 April
                        </p>
                        <p>
                            Partly cloudy. Medium (40%) chance of showers. Light winds.
                        </p>
                        <p>
                            Min 5 Max 17
                        </p>
                    </article> -->
                <!-- </section> -->

                <!-- <section id="content3">
                    <article class="day cloudy">
                        <p>
                            Forecast for Friday 27 April
                        </p>
                        <p>
                            Cloudy. Slight (30%) chance of a shower. Winds southerly 25 to 35 km/h.
                        </p>
                        <p>
                            Min 17 Max 20
                        </p>
                    </article>
                    <article class="day cloudy">
                        <p>
                            Forecast for Saturday 28 April
                        </p>
                        <p>
                            Cloudy. High (70%) chance of showers. Winds southerly 20 to 30 km/h becoming light during the evening.
                        </p>
                        <p>
                            Min 16 Max 20
                        </p>
                    </article>
                    <article class="day cloudy">
                        <p>
                            Forecast for Sunday 29 April
                        </p>
                        <p>
                            Cloudy. Medium (50%) chance of showers. Light winds becoming south to southeasterly 15 to 25 km/h during the morning then becoming light during the evening.
                        </p>
                        <p>
                            Min 15 Max 21
                        </p>
                    </article>
                </section> -->

                <!-- <section id="content4">
                    <article class="day cloudy">
                        <p>
                            Forecast for Friday 27 April
                        </p>
                        <p>
                            Cloudy. Slight (20%) chance of a shower near the Victorian border. Winds south to southwesterly 15 to 20 km/h tending south to southeasterly in the middle of the day then becoming light in the late afternoon. Snow at 1800 m: Below 5%.
                        </p>

                        <div class="limiter">
                            <div class="container-table100">
                                <div class="wrap-table100">
                                    <div class="table">

                                        <div class="row header">
                                            <div class="cell">
                                                Town
                                            </div>
                                            <div class="cell">
                                                Forecast
                                            </div>
                                            <div class="cell">
                                                Min
                                            </div>
                                            <div class="cell">
                                                Max
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="cell" data-title="Town">
                                                Cabramurra
                                            </div>
                                            <div class="cell" data-title="Forecast">
                                                Partly cloudy
                                            </div>
                                            <div class="cell" data-title="Min">
                                                4
                                            </div>
                                            <div class="cell" data-title="Max">
                                                11
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="cell" data-title="Town">
                                                Cooma
                                            </div>
                                            <div class="cell" data-title="Forecast">
                                                Cloudy
                                            </div>
                                            <div class="cell" data-title="Min">
                                                1
                                            </div>
                                            <div class="cell" data-title="Max">
                                                16
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="cell" data-title="Town">
                                                Jindabyne
                                            </div>
                                            <div class="cell" data-title="Forecast">
                                                Cloudy
                                            </div>
                                            <div class="cell" data-title="Min">
                                                3
                                            </div>
                                            <div class="cell" data-title="Max">
                                                12
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="cell" data-title="Town">
                                                Perisher Valley
                                            </div>
                                            <div class="cell" data-title="Forecast">
                                                Partly cloudy
                                            </div>
                                            <div class="cell" data-title="Min">
                                                -3
                                            </div>
                                            <div class="cell" data-title="Max">
                                                8
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="cell" data-title="Town">
                                                Thredbo Top Station
                                            </div>
                                            <div class="cell" data-title="Forecast">
                                                Early fog
                                            </div>
                                            <div class="cell" data-title="Min">
                                                -1
                                            </div>
                                            <div class="cell" data-title="Max">
                                                6
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </article>
                    <article class="day partly-cloudy">
                        <p>
                            Forecast for Saturday 28 April
                        </p>
                        <p>
                            Partly cloudy. The chance of patchy early morning frost. Light winds. Snow at 1800 m: 0%.
                        </p>

                        <div class="limiter">
                            <div class="container-table100">
                                <div class="wrap-table100">
                                    <div class="table">

                                        <div class="row header">
                                            <div class="cell">
                                                Town
                                            </div>
                                            <div class="cell">
                                                Forecast
                                            </div>
                                            <div class="cell">
                                                Min
                                            </div>
                                            <div class="cell">
                                                Max
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="cell" data-title="Town">
                                                Cabramurra
                                            </div>
                                            <div class="cell" data-title="Forecast">
                                                Partly cloudy
                                            </div>
                                            <div class="cell" data-title="Min">
                                                4
                                            </div>
                                            <div class="cell" data-title="Max">
                                                11
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="cell" data-title="Town">
                                                Cooma
                                            </div>
                                            <div class="cell" data-title="Forecast">
                                                Cloudy
                                            </div>
                                            <div class="cell" data-title="Min">
                                                1
                                            </div>
                                            <div class="cell" data-title="Max">
                                                16
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="cell" data-title="Town">
                                                Jindabyne
                                            </div>
                                            <div class="cell" data-title="Forecast">
                                                Cloudy
                                            </div>
                                            <div class="cell" data-title="Min">
                                                3
                                            </div>
                                            <div class="cell" data-title="Max">
                                                12
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="cell" data-title="Town">
                                                Perisher Valley
                                            </div>
                                            <div class="cell" data-title="Forecast">
                                                Partly cloudy
                                            </div>
                                            <div class="cell" data-title="Min">
                                                -3
                                            </div>
                                            <div class="cell" data-title="Max">
                                                8
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="cell" data-title="Town">
                                                Thredbo Top Station
                                            </div>
                                            <div class="cell" data-title="Forecast">
                                                Early fog
                                            </div>
                                            <div class="cell" data-title="Min">
                                                -1
                                            </div>
                                            <div class="cell" data-title="Max">
                                                6
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </article>
                    <article class="day partly-cloudy">
                        <p>
                            Forecast for Sunday 29 April
                        </p>
                        <p>
                            Partly cloudy. Slight (20%) chance of a shower in the east. Light winds. Snow at 1800 m: 0%.
                        </p>

                        <div class="limiter">
                            <div class="container-table100">
                                <div class="wrap-table100">
                                    <div class="table">

                                        <div class="row header">
                                            <div class="cell">
                                                Town
                                            </div>
                                            <div class="cell">
                                                Forecast
                                            </div>
                                            <div class="cell">
                                                Min
                                            </div>
                                            <div class="cell">
                                                Max
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="cell" data-title="Town">
                                                Cabramurra
                                            </div>
                                            <div class="cell" data-title="Forecast">
                                                Partly cloudy
                                            </div>
                                            <div class="cell" data-title="Min">
                                                4
                                            </div>
                                            <div class="cell" data-title="Max">
                                                11
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="cell" data-title="Town">
                                                Cooma
                                            </div>
                                            <div class="cell" data-title="Forecast">
                                                Cloudy
                                            </div>
                                            <div class="cell" data-title="Min">
                                                1
                                            </div>
                                            <div class="cell" data-title="Max">
                                                16
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="cell" data-title="Town">
                                                Jindabyne
                                            </div>
                                            <div class="cell" data-title="Forecast">
                                                Cloudy
                                            </div>
                                            <div class="cell" data-title="Min">
                                                3
                                            </div>
                                            <div class="cell" data-title="Max">
                                                12
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="cell" data-title="Town">
                                                Perisher Valley
                                            </div>
                                            <div class="cell" data-title="Forecast">
                                                Partly cloudy
                                            </div>
                                            <div class="cell" data-title="Min">
                                                -3
                                            </div>
                                            <div class="cell" data-title="Max">
                                                8
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="cell" data-title="Town">
                                                Thredbo Top Station
                                            </div>
                                            <div class="cell" data-title="Forecast">
                                                Early fog
                                            </div>
                                            <div class="cell" data-title="Min">
                                                -1
                                            </div>
                                            <div class="cell" data-title="Max">
                                                6
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </article>

                </section> -->


</xsl:stylesheet>
