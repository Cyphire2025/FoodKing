<template>
    <Swiper dir="ltr" :speed="1000" slidesPerView="auto" :spaceBetween="16" class="menu-slides">
        <SwiperSlide v-for="category in categories" :key="category" class="!w-fit">
            <router-link v-if="design === categoryDesignEnum.FIRST"
                :to="{ name: 'frontend.menu', query: { s: category.slug } }" class="home-category-link">
                <img :src="category.thumb" alt="category">
                <h3>{{ localizeText(category.name) }}</h3>
            </router-link>

            <router-link :class="checkIsQueryAndRouteQuerySame(category.slug) ? 'menu-category-active' : ''"
                v-else-if="design === categoryDesignEnum.SECOND"
                :to="{ name: 'frontend.menu', query: { s: category.slug } }" class="home-category-link">
                <img :src="category.thumb" alt="category">
                <h3>{{ localizeText(category.name) }}</h3>
            </router-link>
        </SwiperSlide>
    </Swiper>
</template>

<script>

import categoryDesignEnum from "../../../enums/modules/categoryDesignEnum";
import { translateFrontendText } from "../../../services/frontendLocalizer";
import { Swiper, SwiperSlide } from 'swiper/vue';
import 'swiper/css';

export default {
    name: "CategoryComponent",
    props: {
        categories: Object,
        design: Number
    },
    components: {
        Swiper,
        SwiperSlide,
    },
    data() {
        return {
            currentCategory: "",
            categoryDesignEnum: categoryDesignEnum,
        }
    },
    mounted() {
        if (this.$route.query.s !== "undefined") {
            this.currentCategory = this.$route.query.s;
        }
    },
    methods: {
        submit: function (msg, e) {
            e.stopPropagation()
        },
        checkIsQueryAndRouteQuerySame(query) {
            if (this.currentCategory === query) {
                return true;
            }
        },
        localizeText(text) {
            return translateFrontendText(text);
        },
    },
    watch: {
        $route(to, from) {
            if (to.query.s !== "undefined") {
                this.currentCategory = to.query.s;
            }
        }
    }
}
</script>
