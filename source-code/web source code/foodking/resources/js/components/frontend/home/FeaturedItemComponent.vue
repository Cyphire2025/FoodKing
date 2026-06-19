<template>
    <LoadingComponent :props="loading" />
    <section class="home-section soft">
        <div class="container" v-if="featuredItems.length > 0">
            <div class="app-section-heading justify-center">
                <div class="app-section-heading-left items-center text-center">
                    <span class="app-section-kicker">{{ $t('frontend_section.handpicked_for_today') }}</span>
                    <h2 class="app-section-title">{{ $t('frontend_section.todays_special') }}</h2>
                    <span class="app-section-underline"></span>
                </div>
            </div>
            <article class="home-special-card w-full">
                <img
                    v-if="specialImageSrc"
                    :src="specialImageSrc"
                    :alt="featuredItem.name"
                    @error="specialImageError"
                >
                <div class="home-special-content">
                    <div class="space-y-3">
                        <span class="home-special-pill">{{ $t('frontend_section.todays_special') }}</span>
                        <div class="space-y-3">
                            <h3 class="text-[28px] md:text-[38px] font-serif font-bold leading-[1.02] text-white drop-shadow-sm max-w-[8ch]">
                                {{ localizeText(featuredItem.name) }}
                            </h3>
                            <p class="max-w-md text-sm md:text-base leading-7 text-white/95 drop-shadow-sm">
                                {{ localizeText(featuredItem.description) }}
                            </p>
                        </div>
                        <p v-if="itemMetaText(featuredItem)" class="text-[11px] md:text-xs uppercase font-bold tracking-[1.2px] text-white/85">
                            {{ itemMetaText(featuredItem) }}
                        </p>
                    </div>

                    <div class="flex flex-wrap items-center gap-3">
                        <button
                            type="button"
                            @click.prevent="openFeaturedItem"
                            class="home-special-pill bg-primary text-white shadow-[0_14px_30px_rgba(109,51,92,0.28)]"
                        >
                            {{ $t('frontend_section.try_now') }}
                        </button>
                        <div class="text-white">
                            <span class="block text-xs uppercase tracking-[1.5px] text-white/70">{{ $t('frontend_section.starting_from') }}</span>
                            <span class="text-2xl md:text-3xl font-bold">{{ featuredPrice }}</span>
                        </div>
                    </div>
                </div>
            </article>
        </div>
    </section>
</template>
<script>

import LoadingComponent from "../components/LoadingComponent";
import { translateFrontendText } from "../../../services/frontendLocalizer";

export default {
    name: "FeaturedItemComponent",
    components: {
        LoadingComponent
    },
    data() {
        return {
            loading: {
                isActive: false,
            },
            specialImageIndex: 0,
        };
    },
    mounted() {
        try {
            this.loading.isActive = true;
            this.$store.dispatch("frontendItem/featured", {
                order_column: "id",
                order_type: "desc"
            }).then(res => {
                this.loading.isActive = false;
            }).catch((err) => {
                this.loading.isActive = false;
            });
        } catch (err) {
            this.loading.isActive = false;
        }
    },
    computed: {
        featuredItems: function () {
            return this.$store.getters["frontendItem/featured"];
        },
        featuredItem: function () {
            return this.featuredItems.length > 0 ? this.featuredItems[0] : {};
        },
        featuredPrice: function () {
            const item = this.featuredItem;
            if (!item || Object.keys(item).length === 0) {
                return "";
            }

            if (Array.isArray(item.offer) && item.offer.length > 0) {
                return item.offer[0].currency_price || item.currency_price || "";
            }

            return item.currency_price || "";
        },
        specialImageCandidates: function () {
            const item = this.featuredItem;
            if (!item || Object.keys(item).length === 0) {
                return [];
            }

            return [
                item.cover,
                this.originalImageUrl(item.cover),
                item.preview,
                this.originalImageUrl(item.preview),
                item.thumb,
                this.originalImageUrl(item.thumb),
                "/images/item/cover.png",
            ].filter((value, index, values) => value && values.indexOf(value) === index);
        },
        specialImageSrc: function () {
            return this.specialImageCandidates[this.specialImageIndex] || "";
        },
    },
    methods: {
        originalImageUrl: function (url) {
            if (!url) {
                return "";
            }

            return url.replace(/\/conversions\/([^/?#]+?)-(cover|thumb|preview)(\.[a-zA-Z0-9]+)([?#].*)?$/, "/$1$3$4");
        },
        specialImageError: function () {
            if (this.specialImageIndex < this.specialImageCandidates.length - 1) {
                this.specialImageIndex++;
            }
        },
        itemMetaText: function (item) {
            if (!item) return "";
            const parts = [];
            const size = `${item.size || ""}`.trim();
            const calories = `${item.calories || ""}`.trim();

            if (size) {
                parts.push(size);
            }

            if (calories) {
                parts.push(/[a-z]/i.test(calories) ? calories : `${calories} kcal`);
            }

            return parts.join(" - ");
        },
        localizeText: function (text) {
            return translateFrontendText(text);
        },
        openFeaturedItem: function () {
            const item = this.featuredItem;
            if (!item || !item.id) return;

            this.$router.push({ name: "frontend.menu", query: { s: item.slug || "" } });
        },
    },
    watch: {
        featuredItem: function () {
            this.specialImageIndex = 0;
        },
    },
};
</script>
