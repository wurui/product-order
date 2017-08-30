<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:oxm="https://www.openxsl.com">

    <xsl:template match="/root" name="wurui.product-order">
        <xsl:param name="pay_url"/>
        <xsl:param name="dsid">e0ee59439b39fcc3</xsl:param>
        <!-- className 'J_OXMod' required  -->

        <div class="J_OXMod oxmod-product-order" ox-mod="product-order" data-uid="{login/uid}" data-dsid="{$dsid}" data-payurl="{$pay_url}">
            <form>
                <!--
                <input type="hidden" name="ds_id" value="{normalize-space(data/product/attribute::ADAPTERID)}"/>
                -->
                <input type="hidden" name="product_id" value="{normalize-space(data/product/id)}"/>
                <input type="hidden" name="price" value="{normalize-space(data/product/price)}"/>
                <input type="hidden" name="title" value="{normalize-space(data/product/title)}"/>
                <div class="product">
                    <span class="mainpic" style="background-image:url({data/product/img/i[1]});"></span>
                    <h3 class="title">
                        <xsl:value-of select="data/product/title"/>
                    </h3>
                    <p>
                        <span class="count">&#215;
                            <span class="J_count">1</span>
                        </span>
                        <span class="price J_price">
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
                                    <input type="number" name="amount" min="1" class="J_input" size="2" value="1"/>
                                    <button type="button" data-action="plus">+</button>
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                配送方式
                            </th>
                            <td>
                                <select name="sendtype">
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
                                    <span class="J_address_name"><xsl:value-of select="normalize-space($defAddr/name)"/></span>
                                    (<span class="J_address_phone"><xsl:value-of select="normalize-space($defAddr/phone)"/></span>)
                                </p>
                                <span class="J_addr_detail">
                                    <span class="J_address_province"><xsl:value-of select="normalize-space($defAddr/province)"/></span>省
                                    <span class="J_address_city"><xsl:value-of select="normalize-space($defAddr/city)"/></span>市
                                    <span class="J_address_district"><xsl:value-of select="normalize-space($defAddr/district)"/></span>区
                                    <span class="J_address_street"><xsl:value-of select="normalize-space($defAddr/street)"/></span>街道
                                    <span class="J_address_detail"><xsl:value-of select="normalize-space($defAddr/detail)"/></span>
                                </span>
                                <button type="button" data-action="popup">&gt;</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <p class="total">
                    合计:&#160;&#160;
                    <span class="price J_total">
                        <xsl:value-of select="data/product/price"/>
                    </span>
                    <input type="hidden" name="total" value="{data/product/price}"/>
                </p>
                <!--
                <p class="payment">
                    支付方式:
                    <label>
                        <input type="radio" name="payment" value="wx"/>
                        <img height="30" src="http://i.oxm1.cc/uploads/git/wurui/img/2aj0kibxjTj0bsj9s9R0vbbA3ij-298.png"/>
                    </label>
                </p>
                -->
                <div class="op">
                    <button class="bt-submit" data-action="submit" type="button">提交订单</button>
                </div>

            </form>

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
                                    <span class="J_address_name"><xsl:value-of select="normalize-space(name)"/></span>(<span class="J_address_phone"><xsl:value-of select="normalize-space(phone)"/></span>)
                                </label>
                                <br/>
                                <label for="{$radio-id}" class="J_addr_detail">
                                    <span class="J_address_province"><xsl:value-of select="normalize-space(province)"/></span>省
                                    <span class="J_address_city"><xsl:value-of select="normalize-space(city)"/></span>市
                                    <span class="J_address_district"><xsl:value-of select="normalize-space(district)"/></span>区
                                    <span class="J_address_street"><xsl:value-of select="normalize-space(street)"/></span>街道
                                    <span class="J_address_detail"><xsl:value-of select="normalize-space(detail)"/></span>
                                </label>
                            </li>
                        </xsl:for-each>
                    </ul>
                    <button class="bt-submit" type="button">确定</button>
                </div>

            </div>
        </div>

    </xsl:template>

</xsl:stylesheet>
