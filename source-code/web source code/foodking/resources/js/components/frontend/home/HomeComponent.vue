<template>
    <LoadingComponent :props="loading" />

    <div class="home-surface">
        <!--========TRACK PART START===========-->
        <TrackOrderComponent />
        <!--========TRACK PART END=============-->

        <!--========BANNER PART START===========-->
        <SliderComponent />
        <!--========BANNER PART END=============-->

        <!--========Category PART START=========-->
        <section v-if="categories.length > 0" class="home-section">
            <div class="container home-menu-panel">
                <div class="app-section-heading mt-4">
                    <div class="app-section-heading-left">
                        <span class="app-section-kicker">{{ $t('frontend_section.fresh_categories') }}</span>
                        <h2 class="app-section-title">{{ $t('frontend_section.explore_our_menu') }}</h2>
                        <span class="app-section-underline"></span>
                    </div>
                    <router-link :to="{ name: 'frontend.menu', query: { s: categoryProps.slug } }"
                        class="app-viewall-link">
                        {{ $t("button.view_all") }}
                    </router-link>
                </div>
                <div class="swiper menu-swiper">
                    <CategoryComponent :categories="categories" :design="categoryProps.design" />
                </div>
            </div>
        </section>
        <!--========Category PART END===========-->

        <!--========FEATURE PART START=========-->
        <FeaturedItemComponent />
        <!--========FEATURE PART END=========-->

        <!--========POPULAR PART START=========-->
        <PopularItemComponent />
        <!--========POPULAR PART START=========-->

        <section v-if="newArrivalItems.length > 0" class="home-section soft">
            <div class="container">
                <div class="app-section-heading">
                    <div class="app-section-heading-left">
                        <span class="app-section-kicker">{{ $t('frontend_section.iced_tea_picks') }}</span>
                        <h2 class="app-section-title">{{ $t('frontend_section.new_arrivals') }}</h2>
                        <span class="app-section-underline"></span>
                    </div>
                    <router-link :to="{ name: 'frontend.menu', query: { s: newArrivalSlug } }" class="app-viewall-link">
                        {{ $t("button.view_all") }}
                    </router-link>
                </div>
                <ItemComponent :items="newArrivalItems" :type="null" :design="itemDesignEnum.GRID" />
            </div>
        </section>

        <section v-if="fruitLoverItems.length > 0" class="home-section">
            <div class="container">
                <div class="app-section-heading">
                    <div class="app-section-heading-left">
                        <span class="app-section-kicker">{{ $t('frontend_section.real_fruit_shots') }}</span>
                        <h2 class="app-section-title">{{ $t('frontend_section.fruit_lovers') }}</h2>
                        <span class="app-section-underline"></span>
                    </div>
                    <router-link :to="{ name: 'frontend.menu', query: { s: fruitLoverSlug } }" class="app-viewall-link">
                        {{ $t("button.view_all") }}
                    </router-link>
                </div>
                <ItemComponent :items="fruitLoverItems" :type="null" :design="itemDesignEnum.GRID" />
            </div>
        </section>

        <!--========OFFER PART START=========-->
        <OfferComponent :limit="limit" />
        <!--========OFFER PART START=========-->
    </div>
</template>

<script>
import SliderComponent from "../../frontend/home/SliderComponent";
import CategoryComponent from "../components/CategoryComponent";
import FeaturedItemComponent from "../home/FeaturedItemComponent";
import PopularItemComponent from "../home/PopularItemComponent";
import OfferComponent from "../components/OfferComponent";
import categoryDesignEnum from "../../../enums/modules/categoryDesignEnum";
import itemDesignEnum from "../../../enums/modules/itemDesignEnum";
import statusEnum from "../../../enums/modules/statusEnum";
import LoadingComponent from "../components/LoadingComponent";
import TrackOrderComponent from "./TrackOrderComponent";
import ItemComponent from "../components/ItemComponent";

export default {
    name: "HomeComponent",
    components: {
        TrackOrderComponent,
        CategoryComponent,
        SliderComponent,
        FeaturedItemComponent,
        PopularItemComponent,
        OfferComponent,
        LoadingComponent,
        ItemComponent
    },
    data() {
        return {
            loading: {
                isActive: false,
            },
            categoryProps: {
                design: categoryDesignEnum.FIRST,
                slug: '',
            },
            limit: 4,
            itemDesignEnum: itemDesignEnum,
            newArrivalItems: [],
            newArrivalSlug: "",
            fruitLoverItems: [],
            fruitLoverSlug: "",
        };
    },
    computed: {
        categories: function () {
            return this.$store.getters["frontendItemCategory/lists"];
        },
    },
    mounted() {
        this.loading.isActive = true;
        this.$store.dispatch("frontendItemCategory/lists", {
            paginate: 0,
            order_column: "sort",
            order_type: "asc",
            status: statusEnum.ACTIVE,
        }).then(res => {
            this.loading.isActive = false;
            this.loadCategoryShowcase();
        }).catch((err) => {
            this.loading.isActive = false;
        });
    },
    methods: {
        findCategorySlug(keywords) {
            const match = this.categories.find((category) => {
                const value = `${category.name || ""} ${category.slug || ""}`.toLowerCase().replace(/-/g, " ");
                return keywords.every((keyword) => value.includes(keyword));
            });
            return match ? match.slug : "";
        },
        loadShowcaseItems(slug, targetItems, targetSlug) {
            if (!slug) {
                return;
            }

            this[targetSlug] = slug;
            this.$store.dispatch("frontendItemCategory/show", {
                slug: slug,
                vuex: false,
            }).then((res) => {
                this[targetItems] = res.data.data.items || [];
            }).catch(() => {
                this[targetItems] = [];
            });
        },
        loadCategoryShowcase() {
            const icedTeaSlug = this.findCategorySlug(["iced", "tea"]);
            const fruitShotsSlug = this.findCategorySlug(["fruit", "shot"]);

            this.loadShowcaseItems(icedTeaSlug, "newArrivalItems", "newArrivalSlug");
            this.loadShowcaseItems(fruitShotsSlug, "fruitLoverItems", "fruitLoverSlug");
        },
    },
    watch: {
        categories: {
            deep: true,
            handler(category) {
                if (category.length > 0) {
                    if (category[0].slug !== "undefined") {
                        this.categoryProps.slug = category[0].slug;
                    }
                    this.loadCategoryShowcase();
                }
            },
        },
    },
};
</script>
