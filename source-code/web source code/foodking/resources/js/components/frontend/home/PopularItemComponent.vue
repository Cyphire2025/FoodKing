<template>
    <LoadingComponent :props="loading" />
    <section class="home-section">
        <div class="container" v-if="popularItems.length > 0">
            <div class="app-section-heading">
                <div class="app-section-heading-left">
                    <span class="app-section-kicker">{{ $t('frontend_section.customer_favorites') }}</span>
                    <h2 class="app-section-title">{{ $t('frontend_section.popular_right_now') }}</h2>
                    <span class="app-section-underline"></span>
                </div>
            </div>
            <ItemComponent
                :items="popularItems"
                :type="itemProps.type"
                :design="itemProps.design"
                grid-class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-6 gap-3 lg:gap-4"
            />
        </div>
    </section>
</template>
<script>

import alertService from "../../../services/alertService";
import itemDesignEnum from "../../../enums/modules/itemDesignEnum";
import ItemComponent from "../components/ItemComponent";
import LoadingComponent from "../components/LoadingComponent";

export default {
    name: "PopularItemComponent",
    components: {
        ItemComponent,
        LoadingComponent
    },
    props: {
        items: Object,
    },
    data() {
        return {
            loading: {
                isActive: false
            },
            itemProps: {
                design: itemDesignEnum.GRID,
                type: null,
            },
        };
    },
    mounted() {
        try {
            this.loading.isActive = true;
            this.$store.dispatch("frontendItem/popular", {
                order_column: "id",
                order_type: "desc",
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
        popularItems: function () {
            return this.$store.getters["frontendItem/popular"];
        }
    }
};
</script>
