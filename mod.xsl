<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:oxm="https://www.openxsl.com">

    <xsl:template match="/root" name="wurui.product-order">
        <!-- className 'J_OXMod' required  -->
        <div class="J_OXMod oxmod-product-order" ox-mod="product-order">

            <div class="product">
                <span class="mainpic" style="background-image:url({data/product/img/i[1]});"></span>
                <h3 class="title">
                    <xsl:value-of select="data/product/title"/>
                </h3>
                <p>
                    <span class="count">&#215;
                        <span class="J_count">1</span>
                    </span>
                    <span class="price">
                        <xsl:value-of select="data/product/price"/>
                    </span>
                </p>
            </div>
            <table class="ordertable" cellpadding="0" cellspacing="0">
                <tbody>
                    <tr>
                        <th>购买数量</th>
                        <td>
                            <span class="num-ctrl">
                                <button type="button" data-action="minus">-</button>
                                <input type="number" min="1" class="J_input" size="2" value="1"/>
                                <button type="button" data-action="plus">+</button>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            配送方式
                        </th>
                        <td>
                            <select>
                                <xsl:for-each select="data/options/i">
                                    <option value="{value}">
                                        <xsl:value-of select="text"/>
                                    </option>
                                </xsl:for-each>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            <nobr>收货地址</nobr>
                        </th>
                        <td>
                            <xsl:variable name="defAddr" select="data/addressbook/i[1]"/>
                            <p class="J_addr_name">
                                <xsl:value-of select="$defAddr/name"/>
                                <xsl:value-of select="$defAddr/phone"/>
                            </p>
                            <span class="J_addr_detail">
                                <xsl:value-of select="$defAddr/province"/>省
                                <xsl:value-of select="$defAddr/city"/>市
                                <xsl:value-of select="$defAddr/district"/>区
                                <xsl:value-of select="$defAddr/street"/>街道
                                <xsl:value-of select="$defAddr/detail"/>
                            </span>
                            <button data-action="popup">&gt;</button>
                        </td>
                    </tr>
                </tbody>
            </table>
            <p class="total">
                合计:&#160;&#160;
                <span class="price">123</span>
            </p>
            <div class="op">
                <button class="bt-submit">提交订单</button>
            </div>
            <div class="popup J_popup">
                <div class="cnt">
                    <ul class="addresslist">
                        <xsl:variable name="uid" select="generate-id(data/addressbook)"/>
                        <xsl:for-each select="data/addressbook/i">
                            <li>
                                <xsl:variable name="radio-id" select="generate-id(.)"/>
                                <span class="sign">
                                    <input type="radio" name="{$uid}" id="{$radio-id}">
                                        <xsl:if test="position() = 1">
                                            <xsl:attribute name="checked">checked</xsl:attribute>
                                        </xsl:if>
                                    </input>
                                </span>
                                <label for="{$radio-id}" class="J_addr_name">
                                    <xsl:value-of select="name"/>(<xsl:value-of select="phone"/>)
                                </label>
                                <br/>
                                <label for="{$radio-id}" class="J_addr_detail">
                                    <xsl:value-of select="province"/>省
                                    <xsl:value-of select="city"/>市
                                    <xsl:value-of select="district"/>区
                                    <xsl:value-of select="street"/>街道
                                    <xsl:value-of select="detail"/>
                                </label>
                            </li>
                        </xsl:for-each>
                    </ul>
                    <button class="bt-submit">确定</button>
                </div>

            </div>
        </div>
    </xsl:template>

</xsl:stylesheet>
